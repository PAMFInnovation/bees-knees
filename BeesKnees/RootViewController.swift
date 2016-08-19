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
    
    // Activities
    let activities: [Activity] = [
        Walk()
    ]
    
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
        
        // Superclass initialization
        super.init(coder: aDecoder)
        
        #if DEBUG
        // DEBUG ONLY: Clear the care plan store
        self._clearStore()
        #endif
        
        // Add the activities to the store
        for activity in activities {
            let carePlanActivity = activity.carePlanActivity()
            
            store.addActivity(carePlanActivity) { success, error in
                if !success {
                    print(error?.localizedDescription)
                }
            }
        }
        
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
    
    
    // MARK: Helpers
    
    private func _clearStore() {
        let deleteGroup = dispatch_group_create()
        let store = self.store
        
        dispatch_group_enter(deleteGroup)
        store.activitiesWithCompletion { (success, activities, errorOrNil) in
            guard success else {
                fatalError(errorOrNil!.localizedDescription)
            }
            
            for activity in activities {
                dispatch_group_enter(deleteGroup)
                store.removeActivity(activity) { (success, error) -> Void in
                    guard success else {
                        fatalError("*** An error occurred: \(error!.localizedDescription)")
                    }
                    dispatch_group_leave(deleteGroup)
                }
            }
            
            dispatch_group_leave(deleteGroup)
        }
        
        // Wait until all the asynchronous calls are done
        dispatch_group_wait(deleteGroup, DISPATCH_TIME_FOREVER)
    }
}