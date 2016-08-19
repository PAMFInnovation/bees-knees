//
//  RootViewController.swift
//  BeesKnees
//
//  Created by Ben Dapkiewicz on 8/18/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit
import CareKit

class RootViewController: UITabBarController {
    
    // Care Plan Store constant
    let store: OCKCarePlanStore
    
    // Navigation controllers
    private var careCardViewController: OCKCareCardViewController!
    private var symptomTrackerViewController: OCKSymptomTrackerViewController!
    
    required init?(coder aDecoder: NSCoder) {
        // Set the directory URL where we'll store the care plan store
        let searchPaths = NSSearchPathForDirectoriesInDomains(.ApplicationSupportDirectory, .UserDomainMask, true)
        let applicationSupportPath = searchPaths[0]
        let persistentDirectoryURL = NSURL(fileURLWithPath: applicationSupportPath)
        
        if !NSFileManager.defaultManager().fileExistsAtPath(persistentDirectoryURL.absoluteString, isDirectory: nil) {
            try! NSFileManager.defaultManager().createDirectoryAtURL(persistentDirectoryURL, withIntermediateDirectories: true, attributes: nil)
        }
        
        // Create the care plan store
        store = OCKCarePlanStore(persistenceDirectoryURL: persistentDirectoryURL)
        
        super.init(coder: aDecoder)
        
        // Create the navigation view controllers
        careCardViewController = createCareCardViewController()
        symptomTrackerViewController = createSymptomTrackerViewController()
        
        // Set the tab bar view controllers
        self.viewControllers = [
            UINavigationController(rootViewController: careCardViewController),
            UINavigationController(rootViewController: symptomTrackerViewController)
        ]
    }
    
    private func createCareCardViewController() -> OCKCareCardViewController {
        let viewController = OCKCareCardViewController(carePlanStore: store)
        
        viewController.title = NSLocalizedString("Care Card", comment: "")
        viewController.tabBarItem = UITabBarItem(title: viewController.title, image: UIImage(named: "carecard"), selectedImage: UIImage(named: "carecard-filled"))
        
        return viewController
    }
    
    private func createSymptomTrackerViewController() -> OCKSymptomTrackerViewController {
        let viewController = OCKSymptomTrackerViewController(carePlanStore: store)
        //viewController.delegate = self
        
        viewController.title = NSLocalizedString("Symptom Tracker", comment: "")
        viewController.tabBarItem = UITabBarItem(title: viewController.title, image: UIImage(named: "symptoms"), selectedImage: UIImage(named: "symptoms-filled"))
        
        return viewController
    }
}