//
//  WelcomeTACController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 1/27/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import UIKit
import ResearchKit


class WelcomeTACController: WelcomeTextViewController {
    
    // MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the button
        let button: HighlightButton = HighlightButton()
        button.setTitle("Review Consent", for: .normal)
        let buttonSize: CGSize = CGSize(width: 160, height: 42)
        let buttonX = (self.view.frame.width / 2) - (buttonSize.width / 2)
        button.frame = CGRect(x: buttonX, y: self.view.frame.height - buttonSize.height - 40, width: buttonSize.width, height: buttonSize.height)
        button.addTarget(self, action: #selector(WelcomeTACController.displayConsent), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    
    // MARK: - Helper functions
    func displayConsent() {
        // Create the Consent TVC
        let consentTVC = ORKTaskViewController(task: ConsentTask, taskRun: nil)
        consentTVC.title = NSLocalizedString("Consent", comment: "")
        consentTVC.delegate = self
        self.present(consentTVC, animated: true, completion: nil)
    }
}

extension WelcomeTACController: ORKTaskViewControllerDelegate {
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        // If Consent, set the first and last name in our ProfileManager singleton
        if taskViewController.title?.localizedCompare("Consent").rawValue == 0 {
            if reason == .completed {
                let result = taskViewController.result.results?[0] as! ORKStepResult
                let signatureResult = result.results?[0] as! ORKConsentSignatureResult
                let firstName = signatureResult.signature?.givenName
                let lastName = signatureResult.signature?.familyName
                
                // If the user is choosing not to consent, we should intervene
                if !signatureResult.consented {
                    let confirm: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    self.alert(message: "Users must accept the Terms of Use in order to continue using the app.", title: "", cancelAction: nil, confirmAction: confirm)
                }
                else {
                    // Set the values in the singleton
                    let name: String = firstName! + " " + lastName!
                    ProfileManager.sharedInstance.updateUserInfo(name: name, email: nil, phone: nil)
                    
                    // Sign the consent document
                    let signedConsent = ConsentDocument.copy()
                    signatureResult.apply(to: signedConsent as! ORKConsentDocument)
                    (signedConsent as! ORKConsentDocument).makePDF(completionHandler: { (data: Data?, error: Error?) in
                        ProfileManager.sharedInstance.updateSignedConsentDocument(data: data!)
                    })
                }
            }
            
            // Navigate to the profile view
            //self.pushViewController(profileVC, animated: true)
            
            // TESTING: removed profile
            /*if shouldPresentPasscode() {
                // Present passcode modally
                self.present(passcodeTVC, animated: true, completion: nil)
            }
            else {
                // Navigate to the transition view if the passcode is already set
                self.pushViewController(preSurgeryTransitionVC, animated: true)
            }*/
        }
            // If Passcode, navigate to the transition view
        /*else if taskViewController.title?.localizedCompare("Protect").rawValue == 0 {
            let _self = self
            // Dismiss the passcode
            taskViewController.dismiss(animated: true, completion: {
                // Navigate to the transition view
                _self.pushViewController(_self.preSurgeryTransitionVC, animated: true)
            })
        }*/
    }
}
