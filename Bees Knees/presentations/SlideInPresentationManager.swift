//
//  SlideInPresentationManager.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 1/19/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import UIKit


enum PresentationDirection {
    case left
    case top
    case right
    case bottom
}

class SlideInPresentationManager: NSObject {
    
    var direction = PresentationDirection.bottom
}

extension SlideInPresentationManager: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = SlideInPresentationController(presentedViewController: presented, presenting: presenting, direction: direction)
        return presentationController
    }
}
