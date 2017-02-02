//
//  WelcomeDateViewController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 1/30/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import UIKit


class WelcomeDateViewController: WelcomeTaskViewController {
    
    var surgerySet: Bool = false
    var setButton: CustomButton?
    var skipButton: CustomButton?
    
    // MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the "set date" button
        setButton = CustomButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), primaryColor: UIColor.white, secondaryColor: UIColor.clear, disabledColor: UIColor.lightGray, textDownColor: Colors.turquoise.color)
        setButton?.borderColor = UIColor.white
        setButton?.borderWidth = 1
        setButton?.cornerRadius = 5
        setButton?.titleLabel?.textAlignment = .center
        setButton?.addTarget(self, action: #selector(WelcomeDateViewController.presentDateViewController), for: .touchUpInside)
        setButton?.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(setButton!)
        self.view.addConstraint(NSLayoutConstraint(item: setButton!, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 20))
        self.view.addConstraint(NSLayoutConstraint(item: setButton!, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: -(self.view.frame.width / 2) - 10))
        self.view.addConstraint(NSLayoutConstraint(item: setButton!, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: -20))
        self.view.addConstraint(NSLayoutConstraint(item: setButton!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50))
        
        // Setup the "skip/continue" button
        skipButton = CustomButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), primaryColor: UIColor.white, secondaryColor: UIColor.clear, disabledColor: UIColor.lightGray, textDownColor: Colors.turquoise.color)
        skipButton?.borderColor = UIColor.white
        skipButton?.borderWidth = 1
        skipButton?.cornerRadius = 5
        skipButton?.titleLabel?.textAlignment = .center
        skipButton?.addTarget(self, action: #selector(WelcomeDateViewController.skip), for: .touchUpInside)
        skipButton?.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(skipButton!)
        self.view.addConstraint(NSLayoutConstraint(item: skipButton!, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: (self.view.frame.width / 2) + 10))
        self.view.addConstraint(NSLayoutConstraint(item: skipButton!, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: -20))
        self.view.addConstraint(NSLayoutConstraint(item: skipButton!, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: -20))
        self.view.addConstraint(NSLayoutConstraint(item: skipButton!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50))
        
        // Change the button text based on date of surgery
        surgerySet = ProfileManager.sharedInstance.isSurgerySet()
        if surgerySet {
            setButton?.setTitle("Edit Date", for: .normal)
            skipButton?.setTitle("Continue", for: .normal)
            completedStackView.transform = CGAffineTransform(scaleX: 1, y: 1)
            grayOutText()
        }
        else {
            setButton?.setTitle("Set Date", for: .normal)
            skipButton?.setTitle("Skip This Step", for: .normal)
        }
    }
    
    
    // MARK: - Helper functions
    func presentDateViewController() {
        let date = DateOfSurgeryPresentViewController()
        date.delegate = self
        self.present(date, animated: true, completion: nil)
    }
    
    func skip() {
        delegate?.completeTask(sender: self)
    }
}

extension WelcomeDateViewController: DateOfSurgeryPresentViewControllerDelegate {
    func complete(sender: DateOfSurgeryPresentViewController) {
        let isSurgerySet = surgerySet
        setButton?.setTitle("Edit Date", for: .normal)
        skipButton?.setTitle("Continue", for: .normal)
        grayOutText()
        surgerySet = true
        sender.dismiss(animated: true, completion: {
            if !isSurgerySet {
                self.markAsCompleted()
            }
        })
    }
}
