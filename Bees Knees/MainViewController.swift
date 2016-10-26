//
//  MainViewController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 10/20/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit
import ResearchKit
import CareKit

class MainViewController: UITabBarController {
    
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
    fileprivate var viewBehindPasscode: UIViewController?
    
    
    required init?(coder aDecoder: NSCoder) {
        // Set the directory URL where we'll store the care plan store
        let searchPaths = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true)
        let applicationSupportPath = searchPaths[0]
        let persistentDirectoryURL = URL(fileURLWithPath: applicationSupportPath)
        
        if !FileManager.default.fileExists(atPath: persistentDirectoryURL.absoluteString, isDirectory: nil) {
            try! FileManager.default.createDirectory(at: persistentDirectoryURL, withIntermediateDirectories: true, attributes: nil)
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
            
            store.add(carePlanActivity) { success, error in
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
    
    override func viewDidAppear(_ animated: Bool) {
        // This app requires a passcode for certain views. Make sure the user has set a passcode before starting with the app
        let passcodeSet = ORKPasscodeViewController.isPasscodeStoredInKeychain()
        if(passcodeSet == false) {
            //let passcodeViewController = ORKTaskViewController(task: PasscodeTask, taskRun: nil)
            //passcodeViewController.delegate = self
            //self.present(passcodeViewController, animated: true, completion: nil)
        }
        
    }
    
    fileprivate func createCareCardViewController() -> OCKCareCardViewController {
        let viewController = OCKCareCardViewController(carePlanStore: store)
        
        viewController.title = NSLocalizedString("Care Card", comment: "")
        viewController.tabBarItem = UITabBarItem(title: viewController.title, image: UIImage(named: "carecard"), selectedImage: UIImage(named: "carecard-filled"))
        
        return viewController
    }
    
    fileprivate func createSymptomTrackerViewController() -> OCKSymptomTrackerViewController {
        let viewController = OCKSymptomTrackerViewController(carePlanStore: store)
        //viewController.delegate = self
        
        viewController.title = NSLocalizedString("Symptom Tracker", comment: "")
        viewController.tabBarItem = UITabBarItem(title: viewController.title, image: UIImage(named: "symptoms"), selectedImage: UIImage(named: "symptoms-filled"))
        
        return viewController
    }
    
    fileprivate func createConsentTaskViewController() -> ORKTaskViewController {
        let viewController = ORKTaskViewController(task: ConsentTask, taskRun: nil)
        viewController.delegate = self;
        
        viewController.title = NSLocalizedString("Consent", comment: "")
        viewController.tabBarItem = UITabBarItem(title: viewController.title, image: UIImage(named: "connect"), selectedImage: UIImage(named: "connect-filled"))
        
        return viewController
    }
    
    fileprivate func createSurveyTaskViewController() -> ORKTaskViewController {
        let viewController = ORKTaskViewController(task: SurveyTask, taskRun: nil)
        viewController.delegate = self;
        
        viewController.title = NSLocalizedString("Survey", comment: "")
        viewController.tabBarItem = UITabBarItem(title: viewController.title, image: UIImage(named: "insights"), selectedImage: UIImage(named: "insights-filled"))
        
        return viewController
    }
    
    fileprivate func createAudioTaskViewController() -> ORKTaskViewController {
        let viewController = ORKTaskViewController(task: MicrophoneTask, taskRun: nil)
        viewController.outputDirectory = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0], isDirectory: true)
        
        viewController.title = NSLocalizedString("Audio", comment: "")
        viewController.tabBarItem = UITabBarItem(title: viewController.title, image: UIImage(named: "insights"), selectedImage: UIImage(named: "insights-filled"))
        
        return viewController
    }
    
    
    // MARK: Helpers
    
    fileprivate func _clearStore() {
        let deleteGroup = DispatchGroup()
        let store = self.store
        
        deleteGroup.enter()
        store.activities { (success, activities, errorOrNil) in
            guard success else {
                fatalError(errorOrNil!.localizedDescription)
            }
            
            for activity in activities {
                deleteGroup.enter()
                store.remove(activity) { (success, error) -> Void in
                    guard success else {
                        fatalError("*** An error occurred: \(error!.localizedDescription)")
                    }
                    deleteGroup.leave()
                }
            }
            
            deleteGroup.leave()
        }
        
        // Wait until all the asynchronous calls are done
        deleteGroup.wait(timeout: DispatchTime.distantFuture)
        
        // Clear the passcode
        ORKPasscodeViewController.removePasscodeFromKeychain()
    }
}

extension MainViewController : ORKTaskViewControllerDelegate {
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        taskViewController.dismiss(animated: true, completion: nil)
    }
}

extension MainViewController : UITabBarControllerDelegate {
    func tabBarController(_ tabBarControlfler: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        // Check for Audio Tab and show Passcode if necessary
        let showPasscode = viewController.title?.localizedCompare("Audio").rawValue == 0
        if(showPasscode) {
            viewBehindPasscode = viewController
            
            let passcodeViewController = ORKPasscodeViewController.passcodeAuthenticationViewController(withText: "Required to access sensitive information.", delegate: self)
            
            self.present(passcodeViewController, animated: true, completion: nil)
            return false
        }
        
        // All other views pass
        return true
    }
}

extension MainViewController : ORKPasscodeDelegate {
    func passcodeViewControllerDidFinish(withSuccess viewController: UIViewController) {
        self.selectedViewController = viewBehindPasscode
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func passcodeViewControllerDidFailAuthentication(_ viewController: UIViewController) {
    }
    
    func passcodeViewControllerDidCancel(_ viewController: UIViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
}
