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
    var preSurgeryTransitionVC: PreSurgeryTransitionViewController!
    
    
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
        // Navigate to the profile view
        self.pushViewController(profileVC, animated: true)
    }
}

extension RootViewController: ProfileDelegate {
    func profileNextButtonPressed(sender: ProfileViewController) {
        // Navigate to the transition view
        self.pushViewController(preSurgeryTransitionVC, animated: true)
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
