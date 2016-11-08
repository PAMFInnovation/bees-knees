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
        //self.addChildViewController(postSurgeryWelcomeFlow)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // TODO: logic for determining if this user already has data and therefore
        // should not repeat the welcome flow
        //
        
        // Present the Pre-Surgery Welcome Flow
        if flowState == .Launch {
            self.present(postSurgeryWelcomeFlow, animated: true, completion: nil)
            //self.present(preSurgeryWelcomeFlow, animated: true, completion: nil)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

extension RootViewController: PreSurgeryWelcomeFlowDelegate {
    func didFinishFlow(sender: PreSurgeryWelcomeFlowViewController) {
        flowState = .PreSurgeryRoutine
        
        // Dismiss the view and the Care Card will be waiting underneath
        self.view.addSubview(preSurgeryRoutineFlow.view)
        self.dismiss(animated: true, completion: nil)
    }
}
