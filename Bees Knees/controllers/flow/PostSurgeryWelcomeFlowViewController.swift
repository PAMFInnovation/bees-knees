//
//  PostSurgeryWelcomeViewController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/7/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit


class PostSurgeryWelcomeFlowViewController: UINavigationController {
    
    // MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        // Add the congrats view
        let congratsView = PostSurgeryCongratsView(frame: self.view.frame)
        let congratsVC = UIViewController()
        congratsVC.title = NSLocalizedString("Post-Surgery", comment: "")
        congratsVC.view = congratsView
        
        // Add the goal reminder view
        let goalView = PostSurgeryGoalView(frame: self.view.frame)
        let goalVC = UIViewController()
        goalVC.title = NSLocalizedString("Your Goal", comment: "")
        goalVC.view = goalView
        
        // Add the welcome view
        let welcomeVC = PostSurgeryWelcomeViewController(nibName: "PostSurgeryWelcomeInterface", bundle: nil)
        welcomeVC.title = NSLocalizedString("Post-Surgery", comment: "")
        
        // Add the transition view
        let transitionView = PostSurgeryTransitionView(frame: self.view.frame)
        let transitionVC = UIViewController()
        transitionVC.title = NSLocalizedString("Post-Surgery", comment: "")
        transitionVC.view = transitionView
        
        // Push the first view
        self.pushViewController(welcomeVC, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}
