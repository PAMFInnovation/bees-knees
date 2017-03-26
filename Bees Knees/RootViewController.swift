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
        CarePlanStoreManager.sharedInstance.updateInsights()
        
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
            break
            
        case .PreSurgeryWelcome:
            self.view.addSubview(welcomeFlow.view)
            welcomeFlow.didMove(toParentViewController: self)
            break
            
        case .PreSurgeryRoutine:
            self.view.addSubview(preSurgeryRoutineFlow.view)
            break
            
        case .PostSurgeryWelcome:
            // Add the pre-surgery routine here.
            // The viewDidAppear will display the post-surgery welcome on top
            // of this view so if they decide to close it, they can easily
            // return back to the pre-surgery routine.
            self.view.addSubview(preSurgeryRoutineFlow.view)
            break
            
        case .PostSurgeryRoutine:
            self.view.addSubview(postSurgeryRoutineFlow.view)
            break
            
        case .Surgery:
            break
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // If the user closes the app while in the post-surgery transition, we
        // want to re-open that here so it's guaranteed to be presented on top
        // of an existing view
        if ProfileManager.sharedInstance.getFlowState() == .PostSurgeryWelcome {
            let vc = PostWelcomePageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
            vc.classDelegate = self
            self.present(vc, animated: true, completion: nil)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    
    // MARK: - Helper functions
    
    func transitionToPostSurgeryWelcomeFlow() {
        ProfileManager.sharedInstance.updateFlowState(.PostSurgeryWelcome)
        
        let vc = PostWelcomePageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
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
    }
}

extension RootViewController: WelcomePageViewControllerDelegate {
    func completeWelcome(sender: WelcomePageViewController) {
        ProfileManager.sharedInstance.updateFlowState(.PreSurgeryRoutine)
        ProfileManager.sharedInstance.setPreSurgeryStartDate(Date())
        
        // By this point, the user will have already selected the location they will be receiving
        // surgery. This is where we should set the location-based content.
        ProfileManager.sharedInstance.loadLocationContent()
        
        // Add the pre-surgery routine view to the hierarchy, which will be displayed underneath
        // the welcome flow. The welcome flow will do a custom transition out by swiping right
        // before rmeoving itself.
        self.view.insertSubview(preSurgeryRoutineFlow.view, belowSubview: welcomeFlow.view)
        welcomeFlow.dismissSelf()
    }
}

extension RootViewController: PostWelcomePageViewControllerDelegate {
    func postWelcomeComplete(sender: PostWelcomePageViewController) {
        ProfileManager.sharedInstance.updateFlowState(.PostSurgeryRoutine)
        
        // Remove the Pre-Surgery Routine Flow
        preSurgeryRoutineFlow.view.removeFromSuperview()
        preSurgeryRoutineFlow.removeFromParentViewController()
        
        // Dismiss the view and the Post Care Card will be waiting underneath
        self.view.addSubview(postSurgeryRoutineFlow.view)
        self.dismiss(animated: true, completion: nil)
    }
    
    func postWelcomeReturn(sender: PostWelcomePageViewController) {
        ProfileManager.sharedInstance.updateFlowState(.PreSurgeryRoutine)
        
        // Dismiss the view and the Pre Care Card will be waiting underneath
        //self.view.addSubview(preSurgeryRoutineFlow.view)
        self.dismiss(animated: true, completion: nil)
    }
}
