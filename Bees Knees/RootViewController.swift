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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // TESTING logic
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let someDate = dateFormatter.date(from: "11/08/2016")
        ProfileManager.sharedInstance.surgeryDate = someDate
        
        // Check for transition to post-surgery by checking the surgery date against today's date
        if flowState == .Launch || flowState == .PreSurgeryWelcome || flowState == .PreSurgeryRoutine {
            if ProfileManager.sharedInstance.surgeryDate != nil {
                // Get today's date
                let today: NSDate = NSDate()
                
                // Do a comparison
                if today as Date > ProfileManager.sharedInstance.surgeryDate! {
                    flowState = .PostSurgeryWelcome
                    self.present(postSurgeryWelcomeFlow, animated: true, completion: nil)
                }
            }
        }
        // TODO: logic for determining if this user already has data and therefore
        // should not repeat the welcome flow
        //
        // Present the Pre-Surgery Welcome Flow
        else if flowState == .Launch {
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
        
        // Dismiss the view and the Care Card will be waiting underneath
        self.view.addSubview(preSurgeryRoutineFlow.view)
        self.dismiss(animated: true, completion: nil)
    }
}

extension RootViewController: PostSurgeryWelcomeFlowDelegate {
    func didFinishPostFlow(sender: PostSurgeryWelcomeFlowViewController) {
        flowState = .PostSurgeryRoutine
        
        // Dismiss the view and the Care Card will be waiting underneath
        self.view.addSubview(postSurgeryRoutineFlow.view)
        self.dismiss(animated: true, completion: nil)
    }
}
