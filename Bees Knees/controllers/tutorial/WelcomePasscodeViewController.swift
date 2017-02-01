//
//  WelcomePasscodeViewController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 1/27/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import UIKit
import ResearchKit


protocol WelcomePasscodeViewControllerDelegate: class {
    func completeOrSkipPasscode(sender: WelcomePasscodeViewController)
}

class WelcomePasscodeViewController: WelcomeTextViewController {
    
    weak var delegate: WelcomePasscodeViewControllerDelegate?
    var confirmButton: CustomButton?
    var skipButton: CustomButton?
    var checkmarkView: UIImageView?
    
    
    // MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the "set passcode" button
        confirmButton = CustomButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), primaryColor: UIColor.white, secondaryColor: UIColor.clear, disabledColor: UIColor.lightGray, textDownColor: Colors.turquoise.color)
        confirmButton?.borderColor = UIColor.white
        confirmButton?.borderWidth = 1
        confirmButton?.cornerRadius = 5
        confirmButton?.titleLabel?.textAlignment = .center
        confirmButton?.addTarget(self, action: #selector(WelcomePasscodeViewController.presentPasscode), for: .touchUpInside)
        confirmButton?.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(confirmButton!)
        self.view.addConstraint(NSLayoutConstraint(item: confirmButton!, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 20))
        self.view.addConstraint(NSLayoutConstraint(item: confirmButton!, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: -(self.view.frame.width / 2) - 10))
        self.view.addConstraint(NSLayoutConstraint(item: confirmButton!, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: -20))
        self.view.addConstraint(NSLayoutConstraint(item: confirmButton!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 60))
        
        // Setup the "skip" button
        skipButton = CustomButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), primaryColor: UIColor.white, secondaryColor: UIColor.clear, disabledColor: UIColor.lightGray, textDownColor: Colors.turquoise.color)
        skipButton?.borderColor = UIColor.white
        skipButton?.borderWidth = 1
        skipButton?.cornerRadius = 5
        skipButton?.titleLabel?.textAlignment = .center
        skipButton?.addTarget(self, action: #selector(WelcomePasscodeViewController.skip), for: .touchUpInside)
        skipButton?.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(skipButton!)
        self.view.addConstraint(NSLayoutConstraint(item: skipButton!, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: (self.view.frame.width / 2) + 10))
        self.view.addConstraint(NSLayoutConstraint(item: skipButton!, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: -20))
        self.view.addConstraint(NSLayoutConstraint(item: skipButton!, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: -20))
        self.view.addConstraint(NSLayoutConstraint(item: skipButton!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 60))
        
        // Add the completed icon
        var checkmarkImage: UIImage = UIImage(named: "checkmark-circle")!
        checkmarkImage = checkmarkImage.withRenderingMode(.alwaysTemplate)
        checkmarkView = UIImageView(image: checkmarkImage)
        checkmarkView?.tintColor = UIColor.white
        checkmarkView?.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(checkmarkView!)
        self.view.addConstraint(NSLayoutConstraint(item: checkmarkView!, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 100))
        self.view.addConstraint(NSLayoutConstraint(item: checkmarkView!, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: checkmarkView!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 75))
        self.view.addConstraint(NSLayoutConstraint(item: checkmarkView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 75))
        
        // Check for passcode already set
        if ORKPasscodeViewController.isPasscodeStoredInKeychain() {
            self.confirmButton?.setTitle("Edit Passcode", for: .normal)
            self.skipButton?.setTitle("Continue", for: .normal)
            self.textView.text = "Your 4-digit passcode has been set!"
            checkmarkView?.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        else {
            self.confirmButton?.setTitle("Set Passcode", for: .normal)
            self.skipButton?.setTitle("Skip This Step", for: .normal)
            checkmarkView?.transform = CGAffineTransform(scaleX: 0, y: 0)
        }
    }
    
    
    // MARK: - Helper functions
    func presentPasscode() {
        if shouldPresentPasscode() {
            let passcodeTVC = ORKTaskViewController(task: PasscodeTask, taskRun: nil)
            passcodeTVC.title = NSLocalizedString("Protect", comment: "")
            passcodeTVC.delegate = self
            self.present(passcodeTVC, animated: true, completion: nil)
        }
        else if ORKPasscodeViewController.isPasscodeStoredInKeychain() {
            self.present(ORKPasscodeViewController.passcodeEditingViewController(withText: "", delegate: self, passcodeType: .type4Digit), animated: true, completion: nil)
        }
    }
    
    func skip() {
        delegate?.completeOrSkipPasscode(sender: self)
    }
    
    func shouldPresentPasscode() -> Bool {
        // Ignore passcode on simulator as it'll cause errors
        var ignorePasscode = false
        #if (arch(i386) || arch(x86_64)) && (os(iOS) || os(watchOS) || os(tvOS))
            ignorePasscode = true
        #endif
        
        // This app requires a passcode for certain views. Make sure the user has set a passcode before starting with the app
        let passcodeSet = ORKPasscodeViewController.isPasscodeStoredInKeychain()
        if ignorePasscode || passcodeSet {
            return false
        }
        else {
            return true
        }
    }
    
    func markAsCompleted() {
        UIView.animate(withDuration: 0.4, animations: {
            self.checkmarkView?.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: { finished in
            UIView.animate(withDuration: 0.1, animations: {
                self.checkmarkView?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: { finished in
                UIView.animate(withDuration: 1.0, animations: {
                }, completion: nil)
            })
        })
    }
}

extension WelcomePasscodeViewController: ORKTaskViewControllerDelegate {
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        // Check for Passcode task
        if taskViewController.title?.localizedCompare("Protect").rawValue == 0 {
            if reason == .completed {
                let _self = self
                
                // Dismiss the passcode and mark this as completed
                self.confirmButton?.setTitle("Edit Passcode", for: .normal)
                self.skipButton?.setTitle("Continue", for: .normal)
                self.textView.text = "Your 4-digit passcode has been set!"
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
