//
//  CarePlanStoreManager.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 10/27/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import Foundation
import CareKit
import ResearchKit


struct SampleAssessmentData {
    let date: DateComponents
    let data: [String]
    
    init(date: DateComponents, data: [String]) {
        self.date = date
        self.data = data
    }
}

struct SampleInterventionData {
    let date: DateComponents
    let data: [Int]
    
    init(date: DateComponents, data: [Int]) {
        self.date = date
        self.data = data
    }
}


protocol CarePlanStoreManagerDelegate: class {
    func carePlanStoreManager(_ manager: CarePlanStoreManager, didUpdateInsights insights: [OCKInsightItem])
}

class CarePlanStoreManager : NSObject {
    
    // Care Card activities will be populated as the user progresses through the app
    fileprivate var activities: [Activity] = []
    
    // Reference to the delegate
    weak var delegate: CarePlanStoreManagerDelegate?
    
    // Care Plan Store constant
    let store: OCKCarePlanStore
    
    // Insights
    var insights: [OCKInsightItem] {
        return insightsBuilder.insights
    }
    private let insightsBuilder: InsightsBuilder
    
    var insightsData: [String: (LineGraphDataSource, InsightGranularity)] = [String: (LineGraphDataSource, InsightGranularity)]()
    
    
    // Singleton
    static let sharedInstance = CarePlanStoreManager()
    fileprivate override init() {
        // Set the directory URL where we'll store the care plan store
        let searchPaths = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true)
        let applicationSupportPath = searchPaths[0]
        let persistentDirectoryURL = URL(fileURLWithPath: applicationSupportPath)
        
        if !FileManager.default.fileExists(atPath: persistentDirectoryURL.absoluteString, isDirectory: nil) {
            try! FileManager.default.createDirectory(at: persistentDirectoryURL, withIntermediateDirectories: true, attributes: nil)
        }
        
        // Create the care plan store
        store = OCKCarePlanStore(persistenceDirectoryURL: persistentDirectoryURL)
        
        // Create the 'InsightsBuilder' to build insights based on the data in the store.
        insightsBuilder = InsightsBuilder(carePlanStore: store)
        
        super.init()
        
        // Register this object as the store's delegate to be notified of changes.
        store.delegate = self
        
        // Add the base activities if we're not in the welcome
        if ProfileManager.sharedInstance.getFlowState() != .Launch &&
            ProfileManager.sharedInstance.getFlowState() != .PreSurgeryWelcome {
            let location = ProfileManager.sharedInstance.getUserLocation()
            self.addBaseActivities(location.activities as! [ActivityModel])
        }
        // Add the recovery assessment if we're in the post surgery routine
        if ProfileManager.sharedInstance.getFlowState() == .PostSurgeryRoutine {
            let location = ProfileManager.sharedInstance.getUserLocation()
            self.addProgressTrackerAssessments(location.assessments as! [AssessmentModel])
            //self.addRecoveryAssessment()
        }
        
        // TEMP: add sample data
        //self._addSampleInterventionData()
        //self._addSampleAssessmentData()
    }
    
    func updateInsights() {
        insightsBuilder.updateInsights { [weak self] completed, newInsights in
            // If new insights have been created, notifiy the delegate.
            guard let storeManager = self, let newInsights = newInsights, completed else { return }
            storeManager.delegate?.carePlanStoreManager(storeManager, didUpdateInsights: newInsights)
        }
    }
    
    
    // MARK: - Helpers
    func resetStore() {
        // Clear the store
        self._clearStore()
        activities = []
        
        // Remove the passcode
        ORKPasscodeViewController.removePasscodeFromKeychain()
    }
    
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
    }
    
    fileprivate func _addSampleInterventionData() {
        
        // Sample data
        var sampleData: [SampleInterventionData] = []
        sampleData.append(SampleInterventionData(
            date: DateComponents(year: 2016, month: 12, day: 18),
            data: [1, 3, 3, 3, 3, 3, 3, 3, 3, 1]))
        sampleData.append(SampleInterventionData(
            date: DateComponents(year: 2016, month: 12, day: 19),
            data: [1, 3, 2, 2, 2, 3, 2, 3, 2, 1]))
        sampleData.append(SampleInterventionData(
            date: DateComponents(year: 2016, month: 12, day: 20),
            data: [0, 1, 1, 2, 1, 1, 0, 0, 0, 0]))
        sampleData.append(SampleInterventionData(
            date: DateComponents(year: 2016, month: 12, day: 21),
            data: [1, 2, 2, 2, 2, 3, 3, 2, 2, 1]))
        sampleData.append(SampleInterventionData(
            date: DateComponents(year: 2016, month: 12, day: 22),
            data: [1, 3, 3, 2, 2, 3, 3, 3, 3, 1]))
        sampleData.append(SampleInterventionData(
            date: DateComponents(year: 2016, month: 12, day: 23),
            data: [1, 3, 3, 3, 2, 2, 1, 3, 3, 1]))
        sampleData.append(SampleInterventionData(
            date: DateComponents(year: 2016, month: 12, day: 24),
            data: [1, 3, 3, 2, 2, 2, 2, 3, 3, 1]))
        sampleData.append(SampleInterventionData(
            date: DateComponents(year: 2016, month: 12, day: 25),
            data: [1, 3, 3, 3, 2, 2, 3, 3, 3, 1]))
        sampleData.append(SampleInterventionData(
            date: DateComponents(year: 2016, month: 12, day: 26),
            data: [1, 3, 3, 3, 3, 2, 2, 2, 3, 1]))
        
 
        // Add the sample data
        for sample in sampleData {
            self.store.events(onDate: sample.date, type: .intervention, completion: { events, error in
                for (index, result) in sample.data.enumerated() {
                    for i in 0..<result {
                        let _index = index
                        let _i = i
                        let result: OCKCarePlanEventResult = OCKCarePlanEventResult(valueString: "10", unitString: "out of 10", userInfo: nil)
                        DispatchQueue.main.async {
                            self.store.update(events[_index][_i], with: result, state: .completed, completion: { success, event, error in
                            })
                        }
                    }
                }
            })
        }
    }
    
    fileprivate func _addSampleAssessmentData() {
        
        // Sample data
        var sampleData: [SampleAssessmentData] = []
        sampleData.append(SampleAssessmentData(
            date: DateComponents(year: 2016, month: 12, day: 18),
            data: ["6", "7", "5"]))
        sampleData.append(SampleAssessmentData(
            date: DateComponents(year: 2016, month: 12, day: 19),
            data: ["5", "9", "4"]))
        sampleData.append(SampleAssessmentData(
            date: DateComponents(year: 2016, month: 12, day: 20),
            data: ["9", "5", "8"]))
        sampleData.append(SampleAssessmentData(
            date: DateComponents(year: 2016, month: 12, day: 21),
            data: ["3", "6", "4"]))
        sampleData.append(SampleAssessmentData(
            date: DateComponents(year: 2016, month: 12, day: 22),
            data: ["2", "7", "4"]))
        sampleData.append(SampleAssessmentData(
            date: DateComponents(year: 2016, month: 12, day: 23),
            data: ["3", "8", "4"]))
        sampleData.append(SampleAssessmentData(
            date: DateComponents(year: 2016, month: 12, day: 24),
            data: ["3", "10", "4"]))
        sampleData.append(SampleAssessmentData(
            date: DateComponents(year: 2016, month: 12, day: 25),
            data: ["3", "8", "4"]))
        sampleData.append(SampleAssessmentData(
            date: DateComponents(year: 2016, month: 12, day: 26),
            data: ["3", "10", "4"]))
        
        // Add the sample data
        for sample in sampleData {
            self.store.events(onDate: sample.date, type: .assessment, completion: { events, error in
                for (index, result) in sample.data.enumerated() {
                    let _index = index
                    let result: OCKCarePlanEventResult = OCKCarePlanEventResult(valueString: result, unitString: "out of 10", userInfo: nil)
                    DispatchQueue.main.async {
                        self.store.update(events[_index].first!, with: result, state: .completed, completion: { success, event, error in
                        })
                    }
                }
            })
        }
    }
    
    func activityWithType(_ type: ActivityType) -> Activity? {
        for activity in activities where activity.activityType == type {
            return activity
        }
        return nil
    }
    
    func assessmentWithType(_ type: ActivityType) -> Assessment? {
        for activity in activities where activity.activityType == type {
            return (activity as! Assessment)
        }
        return nil
    }
    
    func addBaseActivities(_ locationActivities: [ActivityModel]) {
        for activity in locationActivities {
            // Create the activity
            if let activityType = ActivityType(rawValue: activity.type) {
                let activity:Activity = DynamicActivity(activityType: activityType, title: activity.title, instructions: activity.instructions, repetitionsText: activity.repetitionsText, bubbles: activity.bubbles, rationale: activity.rationale, image: activity.image, video: activity.video)

                //if let instantiatedActivity = activity {
                    // Add the activity to the list
                    activities.append(activity)
                    let carePlanActivity = activity.carePlanActivity()
                    
                    // Add the activity to the store
                    self.store.add(carePlanActivity) { success, error in
                        if !success {
                            print("Error adding activity to the store: ", error?.localizedDescription)
                        }
                    }
               // }
            }
        }
    }
    
    func addProgressTrackerAssessments(_ locationProgressTrackerActivities: [AssessmentModel]) {
        for activity in locationProgressTrackerActivities {
            // Create the activity
            if let activityType = ActivityType(rawValue: activity.type) {
                let assessment:Assessment =
                    GenericAssessment(activityType: activityType, title: activity.title, subTitle: activity.subTitle, instructions: activity.title, questions: activity.questions, bubbles: activity.bubbles, repetitionsText: "", rationale: "", image: "", video: "" )
                
                activities.append(assessment)
                let carePlanActivity = assessment.carePlanActivity()
                
                // Add the activity to the store
                self.store.add(carePlanActivity) { success, error in
                    if !success {
                        print("Error adding activity to the store: ", error?.localizedDescription)
                    }
                }
            }
        }

    }
    
//    func addRecoveryAssessment() {
//        if let activityType = ActivityType(rawValue: "Recovery") {
//            let recoveryActivity = Recovery(activityType: activityType, title: "Pain & Recovery", instructions: "", repetitionsText: "", bubbles: "", rationale: "", image: "", video: "")
//            activities.append(recoveryActivity)
//            
//            let recoveryCareActivity = recoveryActivity.carePlanActivity()
//            self.store.add(recoveryCareActivity) { success, error in
//                if !success {
//                    print("Error adding activity to the store: ", error?.localizedDescription)
//                }
//            }
//        }
//        /*let painActivity = KneePain()
//        activities.append(painActivity)
//        
//        let painCareActivity = painActivity.carePlanActivity()
//        self.store.add(painCareActivity) { success, error in
//            if !success {
//                print("Error adding activity to the store: ", error?.localizedDescription)
//            }
//        }*/
//        
////        if let activityType = ActivityType(rawValue: "Mood") {
////            let moodActivity = Mood(activityType: activityType, title: "Mood", instructions: "", repetitionsText: "", bubbles: "", rationale: "", image: "", video: "")
////            activities.append(moodActivity)
////            
////            let moodCareActivity = moodActivity.carePlanActivity()
////            self.store.add(moodCareActivity) { success, error in
////                if !success {
////                    print("Error adding activity to the store: ", error?.localizedDescription)
////                }
////            }
////        }
//    }
    
    func getInsightGranularityForAssessment(_ assessment: String) -> InsightGranularity {
        guard let value = insightsData[assessment] else { return .None }
        return value.1
    }
}

extension CarePlanStoreManager: OCKCarePlanStoreDelegate {
    func carePlanStoreActivityListDidChange(_ store: OCKCarePlanStore) {
        updateInsights()
    }
    
    func carePlanStore(_ store: OCKCarePlanStore, didReceiveUpdateOf event: OCKCarePlanEvent) {
        updateInsights()
    }
}
