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
    
    // Set the initial app's flow state
    var flowState: FlowState = .Launch
    
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
        ProfileManager.sharedInstance.appointments.append(Appointment(title: "Pre-operative appointment", type: .PreOp, date: Util.getDateFromString("11/10/2016")))
        ProfileManager.sharedInstance.appointments.append(Appointment(title: "Orthopedic surgeon appointment", type: .Orthopedic, date: Util.getDateFromString("11/15/2016")))
        ProfileManager.sharedInstance.appointments.append(Appointment(title: "2-week follow up", type: .FollowUp2Week, date: Util.getDateFromString("12/15/2016")))
        ProfileManager.sharedInstance.appointments.append(Appointment(title: "6-week follow up", type: .FollowUp6Week, date: Util.getDateFromString("1/15/2017")))
        ProfileManager.sharedInstance.appointments.append(Appointment(title: "12-week follow up", type: .FollowUp12Week, date: Util.getDateFromString("2/28/2017")))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Check for transition to post-surgery by checking the surgery date against today's date
        if flowState == .Launch || flowState == .PreSurgeryWelcome || flowState == .PreSurgeryRoutine {
            
            // TESTING logic
            if !ProfileManager.sharedInstance.isSurgerySet {
                //ProfileManager.sharedInstance.setSurgeryDate(Util.getDateFromString("11/08/2016"))
                ProfileManager.sharedInstance.setSurgeryDate(Util.getDateFromString("11/30/2016"))
            }
            
            if ProfileManager.sharedInstance.isSurgerySet {
                if Util.isDateInPast(ProfileManager.sharedInstance.getSurgeryDate()) {
                    flowState = .PostSurgeryWelcome
                    self.present(postSurgeryWelcomeFlow, animated: true, completion: nil)
                }
            }
        }
        // TODO: logic for determining if this user already has data and therefore should not repeat the welcome flow
        //
        // Present the Pre-Surgery Welcome Flow
        if flowState == .Launch {
            flowState = .PreSurgeryWelcome
            self.present(preSurgeryWelcomeFlow, animated: true, completion: nil)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

extension RootViewController: PreSurgeryWelcomeFlowDelegate {
    func didFinishPreFlow(sender: PreSurgeryWelcomeFlowViewController) {
        flowState = .PreSurgeryRoutine
        
        // Dismiss the view and the Pre Care Card will be waiting underneath
        self.view.addSubview(preSurgeryRoutineFlow.view)
        self.dismiss(animated: true, completion: nil)
    }
}

extension RootViewController: PostSurgeryWelcomeFlowDelegate {
    func didFinishPostFlow(sender: PostSurgeryWelcomeFlowViewController) {
        flowState = .PostSurgeryRoutine
        
        // Dismiss the view and the Post Care Card will be waiting underneath
        self.view.addSubview(postSurgeryRoutineFlow.view)
        self.dismiss(animated: true, completion: nil)
    }
    
    func returnToPreFlow(sender: PostSurgeryWelcomeFlowViewController) {
        flowState = .PreSurgeryRoutine
        
        // Dismiss the view and the Pre Care Card will be waiting underneath
        self.view.addSubview(preSurgeryRoutineFlow.view)
        self.dismiss(animated: true, completion: nil)
    }
}
