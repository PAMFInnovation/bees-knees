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
    
    
    // MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        // Create the Wilderness Guide VC
        guideVC =  WildernessGuideViewController()
        guideVC.title = NSLocalizedString("My Events", comment: "")
        guideVC.tabBarItem = UITabBarItem(title: "My Events", image: UIImage(named: "guide-icon"), selectedImage: UIImage(named: "guide-icon"))
        
        // Create the CareCard VC
        careCardVC = OCKCareCardViewController(carePlanStore: CarePlanStoreManager.sharedInstance.store)
        careCardVC.delegate = self
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
        settingsVC.title = NSLocalizedString("More", comment: "")
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

extension PreSurgeryRoutineViewController: OCKCareCardViewControllerDelegate {
    func careCardViewController(_ viewController: OCKCareCardViewController, didSelectRowWithInterventionActivity interventionActivity: OCKCarePlanActivity) {
        let activityType = ActivityType(rawValue: interventionActivity.identifier)
        let activity = CarePlanStoreManager.sharedInstance.activityWithType(activityType!)
        let activityContainer = ActivityContainer(activity: activity!, carePlanActivity: interventionActivity)
        let activityVC = ActivityDetailViewController(activityContainer: activityContainer)
        viewController.navigationController?.pushViewController(activityVC, animated: true)
    }
}
