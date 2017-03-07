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
    var leftButton: CustomButton?
    var rightButton: CustomButton?
    
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
        
        // Change the button text based on date of surgery
        surgerySet = ProfileManager.sharedInstance.isSurgerySet()
        if surgerySet {
            leftButton?.setTitle("Edit Date", for: .normal)
            rightButton?.setTitle("Continue", for: .normal)
            completedStackView.transform = CGAffineTransform(scaleX: 1, y: 1)
            grayOutText()
        }
        else {
            leftButton?.setTitle("Skip This Step", for: .normal)
            rightButton?.setTitle("Set Date", for: .normal)
        }
    }
    
    
    // MARK: - Helper functions
    func leftButtonPress() {
        if ProfileManager.sharedInstance.isSurgerySet() {
            // Edit Date
            presentDateViewController()
        }
        else {
            // Skip This Step
            skip()
        }
    }
    
    func rightButtonPress() {
        if ProfileManager.sharedInstance.isSurgerySet() {
            // Continue
            skip()
        }
        else {
            // Set Date
            presentDateViewController()
        }
    }
    
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
        leftButton?.setTitle("Edit Date", for: .normal)
        rightButton?.setTitle("Continue", for: .normal)
        grayOutText()
        surgerySet = true
        sender.dismiss(animated: true, completion: {
            if !isSurgerySet {
                self.markAsCompleted()
            }
        })
    }
}
