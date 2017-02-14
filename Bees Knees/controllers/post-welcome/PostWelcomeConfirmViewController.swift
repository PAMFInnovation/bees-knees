//
//  PostWelcomeConfirmViewController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 2/14/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import UIKit


protocol PostWelcomeConfirmViewControllerDelegate: class {
    func closePostWelcomeFlow()
}

class PostWelcomeConfirmViewController: WelcomeTaskViewController {
    
    var leftButton: CustomButton?
    var rightButton: CustomButton?
    var dateOfSurgeryVC = DateOfSurgeryPresentViewController()
    
    // Class Delegate
    var classDelegate: PostWelcomeConfirmViewControllerDelegate?
    
    
    // MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the "set date" button
        leftButton = CustomButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), primaryColor: UIColor.white, secondaryColor: UIColor.clear, disabledColor: UIColor.lightGray, textDownColor: Colors.turquoise.color)
        leftButton?.borderColor = UIColor.white
        leftButton?.borderWidth = 1
        leftButton?.cornerRadius = 5
        leftButton?.titleLabel?.textAlignment = .center
        leftButton?.addTarget(self, action: #selector(WelcomeDateViewController.leftButtonPress), for: .touchUpInside)
        leftButton?.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(leftButton!)
        self.view.addConstraint(NSLayoutConstraint(item: leftButton!, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 20))
        self.view.addConstraint(NSLayoutConstraint(item: leftButton!, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: -(self.view.frame.width / 2) - 10))
        self.view.addConstraint(NSLayoutConstraint(item: leftButton!, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: -20))
        self.view.addConstraint(NSLayoutConstraint(item: leftButton!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50))
        
        // Setup the "skip/continue" button
        rightButton = CustomButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), primaryColor: UIColor.white, secondaryColor: UIColor.clear, disabledColor: UIColor.lightGray, textDownColor: Colors.turquoise.color)
        rightButton?.borderColor = UIColor.white
        rightButton?.borderWidth = 1
        rightButton?.cornerRadius = 5
        rightButton?.titleLabel?.textAlignment = .center
        rightButton?.addTarget(self, action: #selector(WelcomeDateViewController.rightButtonPress), for: .touchUpInside)
        rightButton?.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(rightButton!)
        self.view.addConstraint(NSLayoutConstraint(item: rightButton!, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: (self.view.frame.width / 2) + 10))
        self.view.addConstraint(NSLayoutConstraint(item: rightButton!, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: -20))
        self.view.addConstraint(NSLayoutConstraint(item: rightButton!, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: -20))
        self.view.addConstraint(NSLayoutConstraint(item: rightButton!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50))
        
        // Create the DateOfSurgery VC
        dateOfSurgeryVC.title = NSLocalizedString("Adjust Date", comment: "")
        dateOfSurgeryVC.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(PostWelcomeConfirmViewController.closeDateViewController))
        
        // Add a confirm button to transition back
        dateOfSurgeryVC.delegate = self
        dateOfSurgeryVC.closeTitle = "Cancel"
        let confirmButton: HighlightButton = HighlightButton()
        confirmButton.setTitle("Confirm", for: .normal)
        let buttonSize: CGSize = CGSize(width: 160, height: 42)
        let buttonX = (self.view.frame.width / 2) - (buttonSize.width / 2)
        confirmButton.frame = CGRect(x: buttonX, y: self.view.frame.height - buttonSize.height - 40, width: buttonSize.width, height: buttonSize.height)
        confirmButton.addTarget(self, action: #selector(PostWelcomeConfirmViewController.surgeryDateAdjusted), for: .touchUpInside)
        dateOfSurgeryVC.view.addSubview(confirmButton)
        
        // Set the button text
        leftButton?.setTitle("Change Date", for: .normal)
        rightButton?.setTitle("Continue", for: .normal)
        
        // We want to auto-advance this page but don't want to display the completed text,
        // so we'll mark that view as hidden
        self.completedStackView.isHidden = true
    }
    
    
    // MARK: - Helper functions
    func leftButtonPress() {
        presentDateViewController()
    }
    
    func rightButtonPress() {
        self.advance()
    }
    
    func presentDateViewController() {
        self.present(dateOfSurgeryVC, animated: true, completion: nil)
    }
    
    func closeDateViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func surgeryDateAdjusted() {
        let _self = self
        
        // Get today's date
        let today: NSDate = NSDate()
        
        // Confirm with the user if the date was set in the past
        if today as Date > ProfileManager.sharedInstance.getSurgeryDate() {
            let cancel: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let confirm: UIAlertAction = UIAlertAction(title: "Yes", style: .default, handler: {(alert: UIAlertAction!) in
                // Return to confirmation view
                _self.dismiss(animated: true, completion: {
                    _self.advance()
                })
            })
            dateOfSurgeryVC.alert(message: "The date you entered has already passed. Did you have your surgery?", title: "", cancelAction: cancel, confirmAction: confirm)
        }
            // Confirm transition back to Pre-Routine
        else {
            let cancel: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let confirm: UIAlertAction = UIAlertAction(title: "Yes", style: .default, handler: {(alert: UIAlertAction!) in
                // Return to confirmation view
                _self.dismiss(animated: true, completion: nil)
                
                // Return to Pre-Routine
                _self.classDelegate?.closePostWelcomeFlow()
            })
            dateOfSurgeryVC.alert(message: "With this new date, your surgery has yet to happen. Proceed back to your Pre-Surgery Routine?", title: "", cancelAction: cancel, confirmAction: confirm)
            
        }
    }
}

extension PostWelcomeConfirmViewController: DateOfSurgeryPresentViewControllerDelegate {
    func complete(sender: DateOfSurgeryPresentViewController) {
        self.dismiss(animated: true, completion: nil)
    }
}
