//
//  RootViewController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 8/18/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit
import ResearchKit


enum FlowState {
    case Launch
    case PreSurgeryWelcome
    case PreSurgeryRoutine
    case Surgery
    case PostSurgeryWelcome
    case PostSurgeryRoutine
}

class RootViewController: UIViewController {
    
    // View controllers
    var preSurgeryWelcomeFlow: PreSurgeryWelcomeFlowViewController!
    var preSurgeryRoutineFlow: PreSurgeryRoutineViewController!
    var postSurgeryWelcomeFlow: PostSurgeryWelcomeFlowViewController!
    var postSurgeryRoutineFlow: PostSurgeryRoutineViewController!
    
    
    required init?(coder aDecoder: NSCoder) {
        // First-time call to CarePlanStoreManager
        CarePlanStoreManager.sharedInstance
        
        // Superclass initialization
        super.init(coder: aDecoder)
        
        // Create the Pre-Surgery Welcome Flow VC
        preSurgeryWelcomeFlow = PreSurgeryWelcomeFlowViewController(coder: aDecoder)
        preSurgeryWelcomeFlow.classDelegate = self
        
        // Create the Pre-Surgery Routine Flow VC
        preSurgeryRoutineFlow = PreSurgeryRoutineViewController(coder: aDecoder)
        self.addChildViewController(preSurgeryRoutineFlow)
        
        // Create the Post-Surgery Welcome Flow VC
        postSurgeryWelcomeFlow = PostSurgeryWelcomeFlowViewController(coder: aDecoder)
        postSurgeryWelcomeFlow.classDelegate = self
        
        // Create the Post-Surgery Routine Flow VC
        postSurgeryRoutineFlow = PostSurgeryRoutineViewController(coder: aDecoder)
        self.addChildViewController(postSurgeryRoutineFlow)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TESTING logic - add some appointments
        ProfileManager.sharedInstance.appointments.append(Appointment(title: "Pre-operative appointment", type: .PreOp))
        ProfileManager.sharedInstance.appointments.append(Appointment(title: "Orthopedic surgeon appointment", type: .Orthopedic))
        ProfileManager.sharedInstance.appointments.append(Appointment(title: "Follow up", type: .FollowUp2Week))
        //ProfileManager.sharedInstance.appointments.append(Appointment(title: "6-week follow up", type: .FollowUp6Week))
        //ProfileManager.sharedInstance.appointments.append(Appointment(title: "12-week follow up", type: .FollowUp12Week))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Check for transition to post-surgery by checking the surgery date against today's date
        if ProfileManager.sharedInstance.flowState == .Launch || ProfileManager.sharedInstance.flowState == .PreSurgeryWelcome || ProfileManager.sharedInstance.flowState == .PreSurgeryRoutine {
            
            // TESTING logic
            if !ProfileManager.sharedInstance.isSurgerySet {
                //ProfileManager.sharedInstance.setSurgeryDate(Util.getDateFromString("11/08/2016"))
                ProfileManager.sharedInstance.setSurgeryDate(Util.getDateFromString("1/24/2017 11:00 am", format: "MM/dd/yyyy h:mm a"))
            }
            
            if ProfileManager.sharedInstance.isSurgerySet {
                if Util.isDateInPast(ProfileManager.sharedInstance.getSurgeryDate()) {
                    self.transitionToPostSurgeryWelcomeFlow()
                }
            }
        }
        // TODO: logic for determining if this user already has data and therefore should not repeat the welcome flow
        //
        // Present the Pre-Surgery Welcome Flow
        if ProfileManager.sharedInstance.flowState == .Launch {
            ProfileManager.sharedInstance.flowState = .PreSurgeryWelcome
            self.present(preSurgeryWelcomeFlow, animated: true, completion: nil)
            
            // Dismiss the view and the Pre Care Card will be waiting underneath
            //ProfileManager.sharedInstance.flowState = .PreSurgeryRoutine
            //self.view.addSubview(preSurgeryRoutineFlow.view)
            
            // Add the tutorial view
            /*let tut = TutorialPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
            self.addChildViewController(tut)
            self.view.addSubview(tut.view)
            tut.didMove(toParentViewController: self)*/
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func transitionToPostSurgeryWelcomeFlow() {
        ProfileManager.sharedInstance.flowState = .PostSurgeryWelcome
        self.present(postSurgeryWelcomeFlow, animated: true, completion: nil)
    }
}

extension RootViewController: PreSurgeryWelcomeFlowDelegate {
    func didFinishPreFlow(sender: PreSurgeryWelcomeFlowViewController) {
        ProfileManager.sharedInstance.flowState = .PreSurgeryRoutine
        
        // Dismiss the view and the Pre Care Card will be waiting underneath
        self.view.addSubview(preSurgeryRoutineFlow.view)
        self.dismiss(animated: true, completion: nil)
    }
}

extension RootViewController: PostSurgeryWelcomeFlowDelegate {
    func didFinishPostFlow(sender: PostSurgeryWelcomeFlowViewController) {
        ProfileManager.sharedInstance.flowState = .PostSurgeryRoutine
        
        // Remove the Pre-Surgery Routine Flow
        preSurgeryRoutineFlow.view.removeFromSuperview()
        preSurgeryRoutineFlow.removeFromParentViewController()
        
        // Dismiss the view and the Post Care Card will be waiting underneath
        self.view.addSubview(postSurgeryRoutineFlow.view)
        self.dismiss(animated: true, completion: nil)
    }
    
    func returnToPreFlow(sender: PostSurgeryWelcomeFlowViewController) {
        ProfileManager.sharedInstance.flowState = .PreSurgeryRoutine
        
        // Dismiss the view and the Pre Care Card will be waiting underneath
        self.view.addSubview(preSurgeryRoutineFlow.view)
        self.dismiss(animated: true, completion: nil)
    }
}
