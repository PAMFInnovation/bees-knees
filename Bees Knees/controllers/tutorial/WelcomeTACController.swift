//
//  WelcomeTACController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 1/27/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import UIKit
import ResearchKit


protocol WelcomeTACControllerDelegate: class {
    func completeTerms(sender: WelcomeTACController)
}

class WelcomeTACController: WelcomeTextViewController {
    
    weak var delegate: WelcomeTACControllerDelegate?
    
    var signButton: CustomButton?
    var viewButton: CustomButton?
    var continueButton: CustomButton?
    var checkmarkView: UIImageView?
    
    
    // MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the buttons
        signButton = CustomButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), primaryColor: UIColor.white, secondaryColor: UIColor.clear, disabledColor: UIColor.lightGray, textDownColor: Colors.turquoise.color)
        signButton?.borderColor = UIColor.white
        signButton?.borderWidth = 1
        signButton?.cornerRadius = 5
        signButton?.titleLabel?.textAlignment = .center
        signButton?.setTitle("Sign Consent", for: .normal)
        signButton?.addTarget(self, action: #selector(WelcomeTACController.displayConsent), for: .touchUpInside)
        signButton?.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(signButton!)
        self.view.addConstraint(NSLayoutConstraint(item: signButton!, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: signButton!, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: -20))
        self.view.addConstraint(NSLayoutConstraint(item: signButton!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 160))
        self.view.addConstraint(NSLayoutConstraint(item: signButton!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 60))
        
        viewButton = CustomButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), primaryColor: UIColor.white, secondaryColor: UIColor.clear, disabledColor: UIColor.lightGray, textDownColor: Colors.turquoise.color)
        viewButton?.borderColor = UIColor.white
        viewButton?.borderWidth = 1
        viewButton?.cornerRadius = 5
        viewButton?.titleLabel?.textAlignment = .center
        viewButton?.setTitle("View Consent", for: .normal)
        viewButton?.addTarget(self, action: #selector(WelcomeTACController.displaySignedConsent), for: .touchUpInside)
        viewButton?.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(viewButton!)
        self.view.addConstraint(NSLayoutConstraint(item: viewButton!, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 20))
        self.view.addConstraint(NSLayoutConstraint(item: viewButton!, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: -(self.view.frame.width / 2) - 10))
        self.view.addConstraint(NSLayoutConstraint(item: viewButton!, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: -20))
        self.view.addConstraint(NSLayoutConstraint(item: viewButton!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 60))
        
        continueButton = CustomButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), primaryColor: UIColor.white, secondaryColor: UIColor.clear, disabledColor: UIColor.lightGray, textDownColor: Colors.turquoise.color)
        continueButton?.borderColor = UIColor.white
        continueButton?.borderWidth = 1
        continueButton?.cornerRadius = 5
        continueButton?.titleLabel?.textAlignment = .center
        continueButton?.setTitle("Continue", for: .normal)
        continueButton?.addTarget(self, action: #selector(WelcomeTACController.nextPage), for: .touchUpInside)
        continueButton?.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(continueButton!)
        self.view.addConstraint(NSLayoutConstraint(item: continueButton!, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: (self.view.frame.width / 2) + 10))
        self.view.addConstraint(NSLayoutConstraint(item: continueButton!, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: -20))
        self.view.addConstraint(NSLayoutConstraint(item: continueButton!, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: -20))
        self.view.addConstraint(NSLayoutConstraint(item: continueButton!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 60))
        
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
        
        // Check for consent and display buttons appropriately
        if ProfileManager.sharedInstance.getSignedConsentDocument() == nil {
            viewButton?.isHidden = true
            continueButton?.isHidden = true
            checkmarkView?.transform = CGAffineTransform(scaleX: 0, y: 0)
        }
        else {
            signButton?.isHidden = true
            checkmarkView?.transform = CGAffineTransform(scaleX: 1, y: 1)
            textView.text = "Consent has been signed! You can tap below to view the signed consent or proceed to the next step."
        }
    }
    
    
    // MARK: - Helper functions
    func displayConsent() {
        // Create the Consent TVC
        let consentTVC = ORKTaskViewController(task: ConsentTask, taskRun: nil)
        consentTVC.title = NSLocalizedString("Consent", comment: "")
        consentTVC.delegate = self
        self.present(consentTVC, animated: true, completion: nil)
    }
    
    func displaySignedConsent() {
        // Present the legal view controller
        self.present(LegalPresentViewController(), animated: true, completion: nil)
    }
    
    func closeLegal() {
        self.dismiss(animated: true, completion: nil)
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
    
    func nextPage() {
        self.delegate?.completeTerms(sender: self)
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
                    taskViewController.alert(message: "Users must accept the Terms of Use in order to continue using the app.", title: "", cancelAction: nil, confirmAction: confirm)
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
                    
                    // Dismiss this view and complete the terms
                    self.signButton?.isHidden = true
                    self.viewButton?.isHidden = false
                    self.continueButton?.isHidden = false
                    self.textView.text = "Consent has been signed! You can tap below to view the signed consent or proceed to the next step."
                    taskViewController.dismiss(animated: true, completion: {
                        self.markAsCompleted()
                    })
                }
            }
            else if reason == .discarded {
                taskViewController.dismiss(animated: true, completion: nil)
            }
        }
    }
}
