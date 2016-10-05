//
//  RootViewController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 8/18/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit
import ResearchKit
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
    private var consentTaskViewController: ORKTaskViewController!
    private var surveyTaskViewController: ORKTaskViewController!
    private var audioTaskViewController: ORKTaskViewController!
    
    // View to proceed to once passcode is successful
    private var viewBehindPasscode: UIViewController?
    
    
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
        
        //#if DEBUG
        // DEBUG ONLY: Clear the care plan store
        self._clearStore()
        //#endif
        
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
        consentTaskViewController = createConsentTaskViewController()
        surveyTaskViewController = createSurveyTaskViewController()
        audioTaskViewController = createAudioTaskViewController()
        
        // Set the tab bar view controllers
        self.viewControllers = [
            UINavigationController(rootViewController: careCardViewController),
            UINavigationController(rootViewController: symptomTrackerViewController),
            UINavigationController(rootViewController: consentTaskViewController),
            UINavigationController(rootViewController: surveyTaskViewController),
            UINavigationController(rootViewController: audioTaskViewController)
        ]
        
        // Set the TabBar delegate
        self.delegate = self;
    }
    
    override func viewDidAppear(animated: Bool) {
        // This app requires a passcode for certain views. Make sure the user has set a passcode before starting with the app
        let passcodeSet = ORKPasscodeViewController.isPasscodeStoredInKeychain()
        if(passcodeSet == false) {
            let passcodeViewController = ORKTaskViewController(task: PasscodeTask, taskRunUUID: nil)
            //passcodeViewController.
            passcodeViewController.delegate = self
            self.presentViewController(passcodeViewController, animated: true, completion: nil)
        }
        
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
    
    private func createConsentTaskViewController() -> ORKTaskViewController {
        let viewController = ORKTaskViewController(task: ConsentTask, taskRunUUID: nil)
        viewController.delegate = self;
        
        viewController.title = NSLocalizedString("Consent", comment: "")
        viewController.tabBarItem = UITabBarItem(title: viewController.title, image: UIImage(named: "connect"), selectedImage: UIImage(named: "connect-filled"))
        
        return viewController
    }
    
    private func createSurveyTaskViewController() -> ORKTaskViewController {
        let viewController = ORKTaskViewController(task: SurveyTask, taskRunUUID: nil)
        viewController.delegate = self;
        
        viewController.title = NSLocalizedString("Survey", comment: "")
        viewController.tabBarItem = UITabBarItem(title: viewController.title, image: UIImage(named: "insights"), selectedImage: UIImage(named: "insights-filled"))
        
        return viewController
    }
    
    private func createAudioTaskViewController() -> ORKTaskViewController {
        let viewController = ORKTaskViewController(task: MicrophoneTask, taskRunUUID: nil)
        viewController.outputDirectory = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0], isDirectory: true)
        
        viewController.title = NSLocalizedString("Audio", comment: "")
        viewController.tabBarItem = UITabBarItem(title: viewController.title, image: UIImage(named: "insights"), selectedImage: UIImage(named: "insights-filled"))
        
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
        
        // Clear the passcode
        ORKPasscodeViewController.removePasscodeFromKeychain()
    }
}

extension RootViewController : ORKTaskViewControllerDelegate {
    func taskViewController(taskViewController: ORKTaskViewController, didFinishWithReason reason: ORKTaskViewControllerFinishReason, error: NSError?) {
        taskViewController.dismissViewControllerAnimated(true, completion: nil)
    }
}

extension RootViewController : UITabBarControllerDelegate {
    func tabBarController(tabBarControlfler: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        // Check for Audio Tab and show Passcode if necessary
        let showPasscode = viewController.title?.localizedCompare("Audio").rawValue == 0
        if(showPasscode) {
            viewBehindPasscode = viewController
            
            let passcodeViewController = ORKPasscodeViewController.passcodeAuthenticationViewControllerWithText("Required to access sensitive information.", delegate: self)
            
            self.presentViewController(passcodeViewController, animated: true, completion: nil)
            return false
        }
        
        // All other views pass
        return true
    }
}

extension RootViewController : ORKPasscodeDelegate {
    func passcodeViewControllerDidFinishWithSuccess(viewController: UIViewController) {
        self.selectedViewController = viewBehindPasscode
        viewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func passcodeViewControllerDidFailAuthentication(viewController: UIViewController) {
    }
    
    func passcodeViewControllerDidCancel(viewController: UIViewController) {
        viewController.dismissViewControllerAnimated(true, completion: nil)
    }
}