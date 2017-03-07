//
//  WelcomePasscodeViewController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 1/27/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import UIKit
import ResearchKit


class WelcomePasscodeViewController: WelcomeTaskViewController {
    
    var leftButton: CustomButton?
    var rightButton: CustomButton?
    
    
    // MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the "set passcode" button
        leftButton = CustomButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), primaryColor: UIColor.white, secondaryColor: UIColor.clear, disabledColor: UIColor.lightGray, textDownColor: Colors.turquoise.color)
        leftButton?.borderColor = UIColor.white
        leftButton?.borderWidth = 1
        leftButton?.cornerRadius = 5
        leftButton?.titleLabel?.textAlignment = .center
        leftButton?.addTarget(self, action: #selector(WelcomePasscodeViewController.leftButtonPress), for: .touchUpInside)
        leftButton?.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(leftButton!)
        self.view.addConstraint(NSLayoutConstraint(item: leftButton!, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 20))
        self.view.addConstraint(NSLayoutConstraint(item: leftButton!, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: -(self.view.frame.width / 2) - 10))
        self.view.addConstraint(NSLayoutConstraint(item: leftButton!, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: -20))
        self.view.addConstraint(NSLayoutConstraint(item: leftButton!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50))
        
        // Setup the "skip" button
        rightButton = CustomButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), primaryColor: UIColor.white, secondaryColor: UIColor.clear, disabledColor: UIColor.lightGray, textDownColor: Colors.turquoise.color)
        rightButton?.borderColor = UIColor.white
        rightButton?.borderWidth = 1
        rightButton?.cornerRadius = 5
        rightButton?.titleLabel?.textAlignment = .center
        rightButton?.addTarget(self, action: #selector(WelcomePasscodeViewController.rightButtonPress), for: .touchUpInside)
        rightButton?.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(rightButton!)
        self.view.addConstraint(NSLayoutConstraint(item: rightButton!, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: (self.view.frame.width / 2) + 10))
        self.view.addConstraint(NSLayoutConstraint(item: rightButton!, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: -20))
        self.view.addConstraint(NSLayoutConstraint(item: rightButton!, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: -20))
        self.view.addConstraint(NSLayoutConstraint(item: rightButton!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50))
        
        // Check for passcode already set
        if Util.isPasscodeSet() {
            self.leftButton?.setTitle("Edit Passcode", for: .normal)
            self.rightButton?.setTitle("Continue", for: .normal)
            completedStackView.transform = CGAffineTransform(scaleX: 1, y: 1)
            grayOutText()
        }
        else {
            self.leftButton?.setTitle("Skip This Step", for: .normal)
            self.rightButton?.setTitle("Set Passcode", for: .normal)
        }
    }
    
    
    // MARK: - Helper functions
    func leftButtonPress() {
        if Util.isPasscodeSet() {
            // Edit Passcode
            self.present(ORKPasscodeViewController.passcodeEditingViewController(withText: "", delegate: self, passcodeType: .type4Digit), animated: true, completion: nil)
        }
        else {
            // Skip This Step
            skip()
        }
    }
    
    func rightButtonPress() {
        if Util.isPasscodeSet() {
            // Continue
            skip()
        }
        else {
            // Set Passcode
            let passcodeTVC = ORKTaskViewController(task: PasscodeTask, taskRun: nil)
            passcodeTVC.title = NSLocalizedString("Protect", comment: "")
            passcodeTVC.delegate = self
            self.present(passcodeTVC, animated: true, completion: nil)
        }
    }
    
    func skip() {
        delegate?.completeTask(sender: self)
    }
}

extension WelcomePasscodeViewController: ORKTaskViewControllerDelegate {
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        // Check for Passcode task
        if taskViewController.title?.localizedCompare("Protect").rawValue == 0 {
            if reason == .completed {
                let _self = self
                
                // Dismiss the passcode and mark this as completed
                self.leftButton?.setTitle("Edit Passcode", for: .normal)
                self.rightButton?.setTitle("Continue", for: .normal)
                grayOutText()
                //self.textView.text = "Your 4-digit passcode has been set!"
                taskViewController.dismiss(animated: true, completion: {
                    self.markAsCompleted()
                })
            }
            else if reason == .discarded {
                taskViewController.dismiss(animated: true, completion: nil)
            }
        }
    }
}

extension WelcomePasscodeViewController: ORKPasscodeDelegate {
    func passcodeViewControllerDidFinish(withSuccess viewController: UIViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func passcodeViewControllerDidFailAuthentication(_ viewController: UIViewController) {
    }
    
    func passcodeViewControllerDidCancel(_ viewController: UIViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
}
