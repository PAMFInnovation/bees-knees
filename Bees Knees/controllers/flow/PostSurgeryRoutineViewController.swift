//
//  PostSurgeryRoutineViewController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/8/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit
import CareKit
import ResearchKit


class PostSurgeryRoutineViewController: UITabBarController {
    
    // Navigation controllers
    fileprivate var guideVC: WildernessGuideViewController!
    fileprivate var careCardVC: OCKCareCardViewController!
    fileprivate var assessmentsVC: OCKSymptomTrackerViewController!
    fileprivate var insightsVC: OCKInsightsViewController!
    fileprivate var settingsVC: SettingsViewController!
    
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
        PhotoLog(),
        KneePain(),
        Mood(),
        IncisionPain()
    ]
    
    
    // MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        /*// Add activities to the store
         for activity in activities {
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
        careCardVC.title = NSLocalizedString("Activities", comment: "")
        careCardVC.tabBarItem = UITabBarItem(title: careCardVC.title, image: UIImage(named: "carecard-icon"), selectedImage: UIImage(named: "carecard-icon"))
        careCardVC.maskImageTintColor = Colors.turquoise.color
        careCardVC.maskImage = UIImage(named: "carecard-heart-large")
        careCardVC.smallMaskImage = UIImage(named: "carecard-heart-small")
        
        // Create the Assessments VC
        assessmentsVC = OCKSymptomTrackerViewController(carePlanStore: CarePlanStoreManager.sharedInstance.store)
        assessmentsVC.delegate = self
        assessmentsVC.title = NSLocalizedString("Progress Tracker", comment: "")
        assessmentsVC.tabBarItem = UITabBarItem(title: assessmentsVC.title, image: UIImage(named: "notes-icon"), selectedImage: UIImage(named: "notes-icon"))
        
        // Create the Insight VC
        CarePlanStoreManager.sharedInstance.delegate = self
        insightsVC = OCKInsightsViewController(insightItems: CarePlanStoreManager.sharedInstance.insights, headerTitle: NSLocalizedString("Progress History", comment: ""), headerSubtitle: "")
        insightsVC.title = NSLocalizedString("Progress History", comment: "")
        insightsVC.tabBarItem = UITabBarItem(title: insightsVC.title, image: UIImage(named: "insights-icon"), selectedImage: UIImage(named: "insights-icon"))
        
        // Create the Settings VC
        settingsVC = SettingsViewController()
        settingsVC.title = NSLocalizedString("More", comment: "")
        settingsVC.tabBarItem = UITabBarItem(title: settingsVC.title, image: UIImage(named: "settings-icon"), selectedImage: UIImage(named: "settings-icon"))
        
        // Set the tab view controllers
        self.viewControllers = [
            UINavigationController(rootViewController: guideVC),
            UINavigationController(rootViewController: careCardVC),
            UINavigationController(rootViewController: assessmentsVC),
            UINavigationController(rootViewController: insightsVC),
            UINavigationController(rootViewController: settingsVC)
        ]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func activityWithType(_ type: ActivityType) -> Activity? {
        for activity in activities where activity.activityType == type {
            return activity
        }
        return nil
    }
}

extension PostSurgeryRoutineViewController: OCKSymptomTrackerViewControllerDelegate {
    // Called when the user taps an assessment
    func symptomTrackerViewController(_ viewController: OCKSymptomTrackerViewController, didSelectRowWithAssessmentEvent assessmentEvent: OCKCarePlanEvent) {
        // Lookup the assessment from the row
        guard let activityType = ActivityType(rawValue: assessmentEvent.activity.identifier) else { return }
        guard let assessment = self.activityWithType(activityType) as? Assessment else { return }
        
        // Check if we should show a task for the selected assessment event
        guard assessmentEvent.state == .initial ||
            assessmentEvent.state == .notCompleted ||
            (assessmentEvent.state == .completed && assessmentEvent.activity.resultResettable) else { return }
        
        // Show the assessment's task
        let taskVC = ORKTaskViewController(task: assessment.task(), taskRun: nil)
        taskVC.delegate = self
        
        // Present the task
        self.present(taskVC, animated: true, completion: nil)
    }
}

extension PostSurgeryRoutineViewController: ORKTaskViewControllerDelegate {
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        // Dismiss the task view controller
        defer {
            self.dismiss(animated: true, completion: nil)
        }
        
        // Ensure the reason this task view controller is finished is due to completion
        guard reason == .completed else { return }
        
        // Determine the event that was completed and the assessment it represents
        guard let event = self.assessmentsVC.lastSelectedAssessmentEvent,
            let activityType = ActivityType(rawValue: event.activity.identifier),
            let assessment = self.activityWithType(activityType) as? Assessment else { return }
        
        // Build an event result object that can be saved into the store
        let carePlanResult = assessment.buildResultForCarePlanEvent(event, taskResult: taskViewController.result)
        
        // Check that the assessment can be associated with a HealthKit sample
        //
        
        // Complete the event
        completeEvent(event, inStore: CarePlanStoreManager.sharedInstance.store, withResult: carePlanResult)
    }
    
    fileprivate func completeEvent(_ event: OCKCarePlanEvent, inStore store: OCKCarePlanStore, withResult result: OCKCarePlanEventResult) {
        print("success with completing activity")
        print(event.activity.description, event.date, event.numberOfDaysSinceStart, event.occurrenceIndexOfDay, event.result, event.state)
        print(result)
        store.update(event, with: result, state: .completed, completion: { success, _, error in
            if !success {
                print(error?.localizedDescription)
            }
        })
    }
}

extension PostSurgeryRoutineViewController: CarePlanStoreManagerDelegate {
    func carePlanStoreManager(_ manager: CarePlanStoreManager, didUpdateInsights insights: [OCKInsightItem]) {
        insightsVC.items = insights
    }
}
