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
    func returnToPreFlow(sender: PostSurgeryWelcomeFlowViewController)
}

class PostSurgeryWelcomeFlowViewController: UINavigationController {
    
    // View controllers
    var adjustSurgeryView: UIView!
    var confirmationVC: UIViewController!
    var adjustDateVC: UIViewController!
    var congratsVC: UIViewController!
    var goalVC: UIViewController!
    var welcomeVC: PostSurgeryWelcomeViewController!
    var transitionVC: UIViewController!
    
    // Class delegate
    weak var classDelegate: PostSurgeryWelcomeFlowDelegate?
    
    // Keep track of the current date of surgery, in case the user changes it
    // and we need to reset
    var currentDateOfSurgery: Date?
    
    
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
        
        // Set the current date of surgery
        currentDateOfSurgery = ProfileManager.sharedInstance.getSurgeryDate()
        
        
        // Add the confirmation view
        let confirmationView = PostSurgeryConfirmationView(frame: self.view.frame)
        confirmationView.delegate = self
        confirmationVC = UIViewController()
        confirmationVC.title = NSLocalizedString("Surgery Completed?", comment: "")
        confirmationVC.view = confirmationView
        
        
        // Add the adjust surgery date view
        adjustSurgeryView = UIView(frame: self.view.frame)
        let dateOfSurgeryView = DateOfSurgeryView.instanceFromNib()
        dateOfSurgeryView.frame = self.view.frame
        adjustSurgeryView.addSubview(dateOfSurgeryView)
        
        // Add a confirm button to transition back
        let confirmButton: UIButton = UIButton(type: .roundedRect)
        confirmButton.setTitle("Confirm", for: .normal)
        confirmButton.borderWidth = 1
        confirmButton.borderColor = UIColor(colorLiteralRed: 0, green: 0.5, blue: 1, alpha: 1)
        confirmButton.cornerRadius = 10
        let buttonSize: CGSize = CGSize(width: 250, height: 42)
        let buttonX = (self.view.frame.width / 2) - (buttonSize.width / 2)
        confirmButton.frame = CGRect(x: buttonX, y: self.view.frame.height - buttonSize.height - 40, width: buttonSize.width, height: buttonSize.height)
        confirmButton.addTarget(self, action: #selector(PostSurgeryWelcomeFlowViewController.surgeryDateAdjusted), for: .touchUpInside)
        adjustSurgeryView.addSubview(confirmButton)
        
        // Set the view controller for the adjust date view
        adjustDateVC = UIViewController()
        adjustDateVC.title = NSLocalizedString("Adjust Date", comment: "")
        adjustDateVC.view = adjustSurgeryView
        
        
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
        
        adjustSurgeryView.frame = self.view.frame
    }
    
    
    // MARK: - Helper functions
    func surgeryDateAdjusted() {
        let _self = self
        
        // Get today's date
        let today: NSDate = NSDate()
        
        // Confirm with the user if the date was set in the past
        if today as Date > ProfileManager.sharedInstance.getSurgeryDate() {
            let cancel: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let confirm: UIAlertAction = UIAlertAction(title: "Yes", style: .default, handler: {(alert: UIAlertAction!) in
                    // Return to confirmation view
                    _self.popViewController(animated: true)
                })
            self.alert(message: "The date you entered has already passed. Did you have your surgery?", title: "", cancelAction: cancel, confirmAction: confirm)
        }
        // Confirm transition back to Pre-Routine
        else {
            let cancel: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let confirm: UIAlertAction = UIAlertAction(title: "Yes", style: .default, handler: {(alert: UIAlertAction!) in
                // Return to Pre-Routine
                _self.classDelegate?.returnToPreFlow(sender: _self)
            })
            self.alert(message: "With this new date, your surgery has yet to happen. Proceed back to your Pre-Surgery Routine?", title: "", cancelAction: cancel, confirmAction: confirm)
        }
    }
}

extension PostSurgeryWelcomeFlowViewController: PostSurgeryConfirmationDelegate {
    func confirmConfirmation(sender: PostSurgeryConfirmationView) {
        self.pushViewController(congratsVC, animated: true)
    }
    
    func adjustSurgeryDate(sender: PostSurgeryConfirmationView) {
        self.pushViewController(adjustDateVC, animated: true)
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
