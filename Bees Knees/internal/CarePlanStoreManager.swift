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
    
    // Care Card activities
    fileprivate var activities: [Activity] = [
        /*Walk(),
        QuadSets(),
        AnklePumps(),
        GluteSets(),
        HeelSlides(),
        StraightLegRaises(),
        SeatedHeelSlides(),
        HamstringSets(),
        ChairPressUps(),
        AbdominalBracing(),
        PhotoLog()*/
        //KneePain(),
        //Mood()
        //IncisionPain(),
        //Recovery()
    ]
    
    fileprivate var baseActivities: [Activity] = [
        Walk(),
        QuadSets(),
        AnklePumps(),
        GluteSets(),
        HeelSlides(),
        StraightLegRaises(),
        SeatedHeelSlides(),
        HamstringSets(),
        ChairPressUps(),
        AbdominalBracing()/*,
        PhotoLog()*/
    ]
    
    // Reference to the delegate
    weak var delegate: CarePlanStoreManagerDelegate?
    
    // Care Plan Store constant
    let store: OCKCarePlanStore
    
    // Insights
    var insights: [OCKInsightItem] {
        return insightsBuilder.insights
    }
    private let insightsBuilder: InsightsBuilder
    
    var insightsData: [String: LineGraphDataSource] = [String: LineGraphDataSource]()
    
    
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
        
        // TEMP: clear the store each time the app is run
        //self._clearStore()
        
        // Add activities to the store
        for activity in baseActivities {
            activities.append(activity)
            let carePlanActivity = activity.carePlanActivity()
            
            self.store.add(carePlanActivity) { success, error in
                if !success {
                    print("Error adding activity to the store: ", error?.localizedDescription)
                }
            }
        }
        if ProfileManager.sharedInstance.getFlowState() == .PostSurgeryRoutine {
            self.addRecoveryAssessment()
        }
        
        // TEMP: add sample data
        //self._addSampleInterventionData()
        //self._addSampleAssessmentData()
        
        // Update insights on launch
        updateInsights()
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
        
        // Add activities to the store
        for activity in baseActivities {
            activities.append(activity)
            let carePlanActivity = activity.carePlanActivity()
            
            self.store.add(carePlanActivity) { success, error in
                if !success {
                    print("Error adding activity to the store: ", error?.localizedDescription)
                }
            }
        }
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
    
    func addRecoveryAssessment() {
        let recoveryActivity = Recovery()
        activities.append(recoveryActivity)
        
        let recoveryCareActivity = recoveryActivity.carePlanActivity()
        self.store.add(recoveryCareActivity) { success, error in
            if !success {
                print("Error adding activity to the store: ", error?.localizedDescription)
            }
        }
        
        
        /*let painActivity = KneePain()
        activities.append(painActivity)
        
        let painCareActivity = painActivity.carePlanActivity()
        self.store.add(painCareActivity) { success, error in
            if !success {
                print("Error adding activity to the store: ", error?.localizedDescription)
            }
        }*/
        
        let moodActivity = Mood()
        activities.append(moodActivity)
        
        let moodCareActivity = moodActivity.carePlanActivity()
        self.store.add(moodCareActivity) { success, error in
            if !success {
                print("Error adding activity to the store: ", error?.localizedDescription)
            }
        }
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