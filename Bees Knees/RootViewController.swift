//
//  RootViewController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 8/18/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit


class RootViewController: UIViewController {
    
    var preSurgeryWelcomeVC: PreSurgeryWelcomeViewController!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Create the PreSurgery Welcome VC and establish the delegate
        preSurgeryWelcomeVC = PreSurgeryWelcomeViewController(nibName: "PreSurgeryWelcomeInterface", bundle: nil)
        preSurgeryWelcomeVC.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.addChildViewController(preSurgeryWelcomeVC)
        self.view.addSubview(preSurgeryWelcomeVC.view)
    }
}

extension RootViewController: PreSurgeryWelcomeNextDelegate {
    func buttonPressed(sender: PreSurgeryWelcomeViewController) {
        print("button pressed")
    }
}
