//
//  PostSurgeryWelcomeViewController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/7/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit


protocol PostSurgeryWelcomeFlowDelegate: class {
    func didFinishPostFlow(sender: PostSurgeryWelcomeFlowViewController)
}

class PostSurgeryWelcomeFlowViewController: UINavigationController {
    
    // View controllers
    var confirmationVC: UIViewController!
    var congratsVC: UIViewController!
    var goalVC: UIViewController!
    var welcomeVC: PostSurgeryWelcomeViewController!
    var transitionVC: UIViewController!
    
    // Class delegate
    weak var classDelegate: PostSurgeryWelcomeFlowDelegate?
    
    
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
        
        // Add the confirmation view
        let confirmationView = PostSurgeryConfirmationView(frame: self.view.frame)
        confirmationView.delegate = self
        confirmationVC = UIViewController()
        confirmationVC.title = NSLocalizedString("Surgery", comment: "")
        confirmationVC.view = confirmationView
        
        // Add the congrats view
        let congratsView = PostSurgeryCongratsView(frame: self.view.frame)
        congratsView.delegate = self
        congratsVC = UIViewController()
        congratsVC.title = NSLocalizedString("Post-Surgery", comment: "")
        congratsVC.view = congratsView
        
        // Add the goal reminder view
        let goalView = PostSurgeryGoalView(frame: self.view.frame)
        goalView.delegate = self
        goalVC = UIViewController()
        goalVC.title = NSLocalizedString("Your Goal", comment: "")
        goalVC.view = goalView
        
        // Add the welcome view
        welcomeVC = PostSurgeryWelcomeViewController(nibName: "PostSurgeryWelcomeInterface", bundle: nil)
        welcomeVC.title = NSLocalizedString("Post-Surgery", comment: "")
        welcomeVC.delegate = self
        
        // Add the transition view
        let transitionView = PostSurgeryTransitionView(frame: self.view.frame)
        transitionView.delegate = self
        transitionVC = UIViewController()
        transitionVC.title = NSLocalizedString("Post-Surgery", comment: "")
        transitionVC.view = transitionView
        
        // Push the first view
        self.pushViewController(confirmationVC, animated: true)
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

extension PostSurgeryWelcomeFlowViewController: PostSurgeryConfirmationDelegate {
    func confirmConfirmation(sender: PostSurgeryConfirmationView) {
        self.pushViewController(congratsVC, animated: true)
    }
    
    func adjustSurgeryDate(sender: PostSurgeryConfirmationView) {
        // TODO
    }
}

extension PostSurgeryWelcomeFlowViewController: PostSurgeryCongratsDelegate {
    func completePostSurgeryCongrats(sender: PostSurgeryCongratsView) {
        self.pushViewController(goalVC, animated: true)
    }
}

extension PostSurgeryWelcomeFlowViewController: PostSurgeryGoalDelegate {
    func completePostSurgeryGoal(sender: PostSurgeryGoalView) {
        self.pushViewController(welcomeVC, animated: true)
    }
}

extension PostSurgeryWelcomeFlowViewController: PostSurgeryWelcomeDelegate {
    func completePostSurgeryWelcome(sender: PostSurgeryWelcomeViewController) {
        self.pushViewController(transitionVC, animated: true)
    }
}

extension PostSurgeryWelcomeFlowViewController: PostSurgeryTransitionDelegate {
    func transitionToPostRoutine(sender: PostSurgeryTransitionView) {
        // We're finished with this flow
        self.classDelegate?.didFinishPostFlow(sender: self)
    }
}
