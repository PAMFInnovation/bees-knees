//
//  SlideInPresentationAnimator.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 1/20/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import UIKit


final class SlideInPresentationAnimator: NSObject {
    
    // MARK: - Properties
    let direction: PresentationDirection
    let isPresentation: Bool
    
    
    // MARK: - Initialization
    init(direction: PresentationDirection, isPresentation: Bool) {
        self.direction = direction
        self.isPresentation = isPresentation
        super.init()
    }
}

extension SlideInPresentationAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // If presenting, use the view we're transitioning "to", otherwise the view we're transitioning "from"
        let key = isPresentation ? UITransitionContextViewControllerKey.to : UITransitionContextViewControllerKey.from
        let controller = transitionContext.viewController(forKey: key)!
        
        // For presentation, add the view to the hierarchy
        if isPresentation {
            transitionContext.containerView.addSubview(controller.view)
        }
        
        // Calculate frames for "to" (present) and "from" (dismiss)
        let presentedFrame = transitionContext.finalFrame(for: controller)
        var dismissedFrame = presentedFrame
        switch direction {
        case .left:
            dismissedFrame.origin.x = -presentedFrame.width
        case .right:
            dismissedFrame.origin.x = transitionContext.containerView.frame.size.width
        case .top:
            dismissedFrame.origin.y = -presentedFrame.height
        case .bottom:
            dismissedFrame.origin.y = transitionContext.containerView.frame.size.height
        }
        
        // Determine the transition’s initial and final frames. When presenting the view controller,
        // it moves from the dismissed frame to the presented frame — vice versa when dismissing.
        let initialFrame = isPresentation ? dismissedFrame : presentedFrame
        let finalFrame = isPresentation ? presentedFrame : dismissedFrame
        
        // Animate from initial to final
        let animationDuration = transitionDuration(using: transitionContext)
        controller.view.frame = initialFrame
        UIView.animate(withDuration: animationDuration, animations: {
            controller.view.frame = finalFrame
        }) { finished in
            transitionContext.completeTransition(finished)
        }
    }
}
