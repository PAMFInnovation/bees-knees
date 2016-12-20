//
//  PreSurgeryRoutineViewController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 10/27/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit
import CareKit


class PreSurgeryRoutineViewController: UITabBarController, UITabBarControllerDelegate {
    
    // Navigation controllers
    private var guideVC: WildernessGuideViewController!
    private var careCardVC: OCKCareCardViewController!
    private var checklistVC: PreSurgeryChecklistViewController!
    private var settingsVC: SettingsViewController!
    
    // Care Card activities
    let activities: [Activity] = [
        Walk(),
        QuadSets(),
        AnklePumps(),
        GluteSets(),
        HeelSlides(),
        StraightLegRaises(),
        SeatedHeelSlides(),
        HamstringSets(),
        ChairPressUps(),
        AbdominalBracing(),
        PhotoLog()
    ]
    
    
    // MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Add activities to the store
        /*for activity in activities {
            let carePlanActivity = activity.carePlanActivity()
            
            CarePlanStoreManager.sharedInstance.store.add(carePlanActivity) { success, error in
                if !success {
                    print("Error adding activity to the store: ", error?.localizedDescription)
                }
            }
        }*/
        
        // Create the Wilderness Guide VC
        guideVC =  WildernessGuideViewController()
        guideVC.title = NSLocalizedString("My Roadmap to Recovery", comment: "")
        guideVC.tabBarItem = UITabBarItem(title: "My Roadmap", image: UIImage(named: "guide-icon"), selectedImage: UIImage(named: "guide-icon"))
        
        // Create the CareCard VC
        careCardVC = OCKCareCardViewController(carePlanStore: CarePlanStoreManager.sharedInstance.store)
        careCardVC.title = NSLocalizedString("Physical Preparation Activities", comment: "")
        careCardVC.tabBarItem = UITabBarItem(title: "Activities", image: UIImage(named: "carecard-icon"), selectedImage: UIImage(named: "carecard-icon"))
        careCardVC.maskImageTintColor = Colors.turquoise.color
        careCardVC.maskImage = UIImage(named: "carecard-heart-large")
        careCardVC.smallMaskImage = UIImage(named: "carecard-heart-small")
        
        // Create the Checklist VC
        checklistVC = PreSurgeryChecklistViewController()
        checklistVC.title = NSLocalizedString("To-Do's Before Surgery", comment: "")
        checklistVC.tabBarItem = UITabBarItem(title: "To-Do's", image: UIImage(named: "checklist-icon"), selectedImage: UIImage(named: "checklist-icon"))
        
        // Create the Settings VC
        settingsVC = SettingsViewController()
        settingsVC.title = NSLocalizedString("Settings", comment: "")
        settingsVC.tabBarItem = UITabBarItem(title: settingsVC.title, image: UIImage(named: "settings-icon"), selectedImage: UIImage(named: "settings-icon"))
        
        // Set the tab view controllers
        self.viewControllers = [
            UINavigationController(rootViewController: guideVC),
            UINavigationController(rootViewController: careCardVC),
            UINavigationController(rootViewController: checklistVC),
            UINavigationController(rootViewController: settingsVC)
        ]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Set default tab
        self.selectedIndex = 0
    }
}
