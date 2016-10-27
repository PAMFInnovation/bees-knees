//
//  RootViewController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 8/18/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit
import ResearchKit


class RootViewController: UINavigationController {
    
    var preSurgeryWelcomeVC: PreSurgeryWelcomeViewController!
    var consentTVC: ORKTaskViewController!
    var profileVC: ProfileViewController!
    var preSurgeryTransitionVC: PreSurgeryTransitionViewController!
    var passcodeTVC: ORKTaskViewController!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Create the PreSurgery Welcome VC and establish the delegate
        preSurgeryWelcomeVC = PreSurgeryWelcomeViewController(nibName: "PreSurgeryWelcomeInterface", bundle: nil)
        preSurgeryWelcomeVC.title = NSLocalizedString("Welcome", comment: "")
        preSurgeryWelcomeVC.delegate = self
        
        // Create the Consent TVC
        consentTVC = ORKTaskViewController(task: ConsentTask, taskRun: nil)
        consentTVC.title = NSLocalizedString("Consent", comment: "")
        consentTVC.delegate = self
        
        // Create the Profile VC
        profileVC = ProfileViewController(nibName: "ProfileInterface", bundle: nil)
        profileVC.title = NSLocalizedString("Profile", comment: "")
        profileVC.delegate = self
        
        // Create the passcode TVC
        passcodeTVC = ORKTaskViewController(task: PasscodeTask, taskRun: nil)
        passcodeTVC.title = NSLocalizedString("Protect", comment: "")
        passcodeTVC.delegate = self
        
        // Create the PreSurgery Transition VC
        preSurgeryTransitionVC = PreSurgeryTransitionViewController(nibName: "PreSurgeryTransitionInterface", bundle: nil)
        preSurgeryTransitionVC.title = NSLocalizedString("Pre-Surgery", comment: "")
        preSurgeryTransitionVC.delegate = self
        
        // Set the view controllers
        self.viewControllers = [
            preSurgeryWelcomeVC
        ]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension RootViewController: PreSurgeryWelcomeDelegate {
    func preSurgeryNextButtonPressed(sender: PreSurgeryWelcomeViewController) {
        // Navigate to the consent view
        self.pushViewController(consentTVC, animated: true)
    }
}

extension RootViewController: ORKTaskViewControllerDelegate {
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        // Set the first and last name of the consent view in our ProfileManager singleton
        if reason == .completed {
            let result = taskViewController.result.results?[1] as! ORKStepResult
            let signatureResult = result.results?[0] as! ORKConsentSignatureResult
            let firstName = signatureResult.signature?.givenName
            let lastName = signatureResult.signature?.familyName
            
            // Set the values in the singleton
            ProfileManager.sharedInstance.name = firstName! + " " + lastName!
        }
        
        // Navigate to the profile view
        self.pushViewController(profileVC, animated: true)
    }
}

extension RootViewController: ProfileDelegate {
    func profileNextButtonPressed(sender: ProfileViewController) {
        // This app requires a passcode for certain views. Make sure the user has set a passcode before starting with the app
        let passcodeSet = ORKPasscodeViewController.isPasscodeStoredInKeychain()
        if passcodeSet {
            // Navigate to the transition view if the passcode is already set
            self.pushViewController(preSurgeryTransitionVC, animated: true)
        }
        else {
            self.pushViewController(passcodeTVC, animated: true)
        }
    }
}

extension RootViewController: ORKPasscodeDelegate {
    func passcodeViewControllerDidFinish(withSuccess viewController: UIViewController) {
        print("passcode finished")
        
        // Navigate to the transition view
        self.pushViewController(preSurgeryTransitionVC, animated: true)
    }
    
    func passcodeViewControllerDidFailAuthentication(_ viewController: UIViewController) {
        print("passcode failed authentication")
    }
}

extension RootViewController: PreSurgeryTransitionDelegate {
    func setSurgeryButtonPressed(sender: PreSurgeryTransitionViewController) {
        print("set surgery button")
    }
    
    func goToCareCardButtonPressed(sender: PreSurgeryTransitionViewController) {
        print("go to care card")
    }
}
