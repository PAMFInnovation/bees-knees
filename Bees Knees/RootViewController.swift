//
//  RootViewController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 8/18/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit


class RootViewController: UINavigationController {
    
    var preSurgeryWelcomeVC: PreSurgeryWelcomeViewController!
    var profileVC: ProfileViewController!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Create the PreSurgery Welcome VC and establish the delegate
        preSurgeryWelcomeVC = PreSurgeryWelcomeViewController(nibName: "PreSurgeryWelcomeInterface", bundle: nil)
        preSurgeryWelcomeVC.title = NSLocalizedString("Welcome", comment: "")
        preSurgeryWelcomeVC.delegate = self
        
        // Create the Profile VC
        profileVC = ProfileViewController(nibName: "ProfileInterface", bundle: nil)
        profileVC.title = NSLocalizedString("Profile", comment: "")
        profileVC.delegate = self
        
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

extension RootViewController: PreSurgeryWelcomeNextDelegate {
    func preSurgeryNextButtonPressed(sender: PreSurgeryWelcomeViewController) {
        // Navigate to the profile view
        self.pushViewController(profileVC, animated: true)
    }
}

extension RootViewController: ProfileNextDelegate {
    func profileNextButtonPressed(sender: ProfileViewController) {
        print("profile button pressed")
    }
}
