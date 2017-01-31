//
//  WelcomeTransitionViewController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 1/30/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import UIKit


protocol WelcomeTransitionViewControllerDelegate: class {
    func transition(sender: WelcomeTransitionViewController)
}

class WelcomeTransitionViewController: WelcomeTextViewController {
    
    weak var delegate: WelcomeTransitionViewControllerDelegate?
    
    
    // MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the buttons
        let goButton = CustomButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), primaryColor: UIColor.white, secondaryColor: Colors.turquoise.color, disabledColor: UIColor.lightGray)
        goButton.borderColor = UIColor.white
        goButton.borderWidth = 1
        goButton.cornerRadius = 5
        goButton.titleLabel?.textAlignment = .center
        goButton.setTitle("Let's Go!", for: .normal)
        goButton.addTarget(self, action: #selector(WelcomeTransitionViewController.complete), for: .touchUpInside)
        goButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(goButton)
        self.view.addConstraint(NSLayoutConstraint(item: goButton, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: goButton, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: -20))
        self.view.addConstraint(NSLayoutConstraint(item: goButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 160))
        self.view.addConstraint(NSLayoutConstraint(item: goButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 60))
    }
    
    
    // MARK: - Helper functions
    func complete() {
        self.delegate?.transition(sender: self)
    }
}
