//
//  PreSurgeryRoutineViewController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 10/27/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit
import CareKit


class PreSurgeryRoutineViewController: UITabBarController {
    
    // Navigation controllers
    private var careCardVC: OCKCareCardViewController!
    private var checklistVC: PreSurgeryChecklistViewController!
    
    // Care Card activities
    let activities: [Activity] = [
        Walk()
    ]
    
    
    // MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Add activities to the store
        for activity in activities {
            let carePlanActivity = activity.carePlanActivity()
            
            CarePlanStoreManager.sharedInstance.store.add(carePlanActivity) { success, error in
                if !success {
                    print("Error adding activity to the store: ", error?.localizedDescription)
                }
            }
        }
        
        // Create the CareCard VC
        careCardVC = OCKCareCardViewController(carePlanStore: CarePlanStoreManager.sharedInstance.store)
        careCardVC.title = NSLocalizedString("Care Card", comment: "")
        careCardVC.tabBarItem = UITabBarItem(title: careCardVC.title, image: UIImage(named: "carecard"), selectedImage: UIImage(named: "carecard-filled"))
        
        // Create the Checklist VC
        checklistVC = PreSurgeryChecklistViewController()
        checklistVC.title = NSLocalizedString("Checklist", comment: "")
        checklistVC.tabBarItem = UITabBarItem(title: checklistVC.title, image: UIImage(named: "TEMP-checklist-icon"), selectedImage: UIImage(named: "TEMP-checklist-icon"))
        
        // Set the tab view controllers
        self.viewControllers = [
            UINavigationController(rootViewController: careCardVC),
            UINavigationController(rootViewController: checklistVC)
        ]
    }
}
