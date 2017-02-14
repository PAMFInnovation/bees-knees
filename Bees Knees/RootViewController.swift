//
//  RootViewController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 8/18/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit
import ResearchKit


@objc enum FlowState: Int {
    case Launch
    case PreSurgeryWelcome
    case PreSurgeryRoutine
    case Surgery
    case PostSurgeryWelcome
    case PostSurgeryRoutine
}

class RootViewController: UIViewController {
    
    // View controllers
    var welcomeFlow: WelcomePageViewController!
    var preSurgeryRoutineFlow: PreSurgeryRoutineViewController!
    var postSurgeryRoutineFlow: PostSurgeryRoutineViewController!
    
    
    required init?(coder aDecoder: NSCoder) {
        // First-time call to CarePlanStoreManager
        CarePlanStoreManager.sharedInstance
        
        // First-time call to ProfileManager
        ProfileManager.sharedInstance
        
        // Superclass initialization
        super.init(coder: aDecoder)
        
        // Create the welcome flow VC
        welcomeFlow = WelcomePageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        welcomeFlow.classDelegate = self
        self.addChildViewController(welcomeFlow)
        
        // Create the Pre-Surgery Routine Flow VC
        preSurgeryRoutineFlow = PreSurgeryRoutineViewController()
        self.addChildViewController(preSurgeryRoutineFlow)
        
        // Create the Post-Surgery Routine Flow VC
        postSurgeryRoutineFlow = PostSurgeryRoutineViewController()
        self.addChildViewController(postSurgeryRoutineFlow)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Check for transition to post-surgery by checking the surgery date against today's date
        if /*ProfileManager.sharedInstance.user.flowState == .Launch ||
            ProfileManager.sharedInstance.user.flowState == .PreSurgeryWelcome ||*/
            ProfileManager.sharedInstance.user.flowState == .PreSurgeryRoutine {
            
            // If the surgery date has passed, transition to post-surgery welcome
            if ProfileManager.sharedInstance.isSurgerySet() &&
                Util.isDateInPast(ProfileManager.sharedInstance.getSurgeryDate()) {
                self.transitionToPostSurgeryWelcomeFlow()
            }
        }
        
        
        // Determine where to go from the initial app flow state
        switch(ProfileManager.sharedInstance.getFlowState()) {
        case .Launch:
            ProfileManager.sharedInstance.updateFlowState(.PreSurgeryWelcome)
            
            self.view.addSubview(welcomeFlow.view)
            welcomeFlow.didMove(toParentViewController: self)
            
            /*let vc = PreSurgeryWelcomeFlowViewController()
             vc.classDelegate = self
             self.present(vc, animated: true, completion: nil)*/
            break
            
        case .PreSurgeryWelcome:
            self.view.addSubview(welcomeFlow.view)
            welcomeFlow.didMove(toParentViewController: self)
            
            /*let vc = PreSurgeryWelcomeFlowViewController()
             vc.classDelegate = self
             self.present(vc, animated: true, completion: nil)*/
            break
            
        case .PreSurgeryRoutine:
            self.view.addSubview(preSurgeryRoutineFlow.view)
            break
            
        case .PostSurgeryWelcome:
            let vc = PostSurgeryWelcomeFlowViewController()
            vc.classDelegate = self
            self.present(vc, animated: true, completion: nil)
            break
            
        case .PostSurgeryRoutine:
            self.view.addSubview(postSurgeryRoutineFlow.view)
            break
            
        case .Surgery:
            break
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    
    // MARK: - Helper functions
    
    func transitionToPostSurgeryWelcomeFlow() {
        ProfileManager.sharedInstance.updateFlowState(.PostSurgeryWelcome)
        let vc = PostSurgeryWelcomeFlowViewController()
        vc.classDelegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    func transitionToLaunch(from: FlowState) {
        // Remove either the pre-surgery routine or the post-surgery routine, whichever
        // may have been active.
        if from == .PreSurgeryRoutine{
            preSurgeryRoutineFlow.view.removeFromSuperview()
            preSurgeryRoutineFlow.removeFromParentViewController()
        }
        else if from == .PostSurgeryRoutine {
            postSurgeryRoutineFlow.view.removeFromSuperview()
            postSurgeryRoutineFlow.removeFromParentViewController()
        }
        
        // Recreate the welcome flow view controller
        welcomeFlow = WelcomePageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        welcomeFlow.classDelegate = self
        
        // Recreate the routine view controllers
        preSurgeryRoutineFlow = PreSurgeryRoutineViewController()
        postSurgeryRoutineFlow = PostSurgeryRoutineViewController()
        
        // Transition to the welcome
        ProfileManager.sharedInstance.updateFlowState(.PreSurgeryWelcome)
        self.view.addSubview(welcomeFlow.view)
        welcomeFlow.didMove(toParentViewController: self)
        
        /*// Transition to the pre-surgery welcome
        ProfileManager.sharedInstance.updateFlowState(.PreSurgeryWelcome)
        let vc = PreSurgeryWelcomeFlowViewController()
        vc.classDelegate = self
        self.present(vc, animated: true, completion: nil)*/
    }
}

/*extension RootViewController: PreSurgeryWelcomeFlowDelegate {
    func didFinishPreFlow(sender: PreSurgeryWelcomeFlowViewController) {
        ProfileManager.sharedInstance.updateFlowState(.PreSurgeryRoutine)
        
        // Dismiss the view and the Pre Care Card will be waiting underneath
        self.view.addSubview(preSurgeryRoutineFlow.view)
        self.dismiss(animated: true, completion: nil)
    }
}*/

extension RootViewController: WelcomePageViewControllerDelegate {
    func completeWelcome(sender: WelcomePageViewController) {
        ProfileManager.sharedInstance.updateFlowState(.PreSurgeryRoutine)
        
        // Add the pre-surgery routine view to the hierarchy, which will be displayed underneath
        // the welcome flow. The welcome flow will do a custom transition out by swiping right
        // before rmeoving itself.
        self.view.insertSubview(preSurgeryRoutineFlow.view, belowSubview: welcomeFlow.view)
        welcomeFlow.dismissSelf()
    }
}

extension RootViewController: PostSurgeryWelcomeFlowDelegate {
    func didFinishPostFlow(sender: PostSurgeryWelcomeFlowViewController) {
        ProfileManager.sharedInstance.updateFlowState(.PostSurgeryRoutine)
        
        // Remove the Pre-Surgery Routine Flow
        preSurgeryRoutineFlow.view.removeFromSuperview()
        preSurgeryRoutineFlow.removeFromParentViewController()
        
        // Dismiss the view and the Post Care Card will be waiting underneath
        self.view.addSubview(postSurgeryRoutineFlow.view)
        self.dismiss(animated: true, completion: nil)
    }
    
    func returnToPreFlow(sender: PostSurgeryWelcomeFlowViewController) {
        ProfileManager.sharedInstance.updateFlowState(.PreSurgeryRoutine)
        ProfileManager.sharedInstance.setPreSurgeryStartDate(Date())
        
        // Dismiss the view and the Pre Care Card will be waiting underneath
        self.view.addSubview(preSurgeryRoutineFlow.view)
        self.dismiss(animated: true, completion: nil)
    }
}
