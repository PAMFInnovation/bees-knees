//
//  CarePlanStoreManager.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 10/27/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import Foundation
import CareKit


protocol CarePlanStoreManagerDelegate: class {
    func carePlanStoreManager(_ manager: CarePlanStoreManager, didUpdateInsights insights: [OCKInsightItem])
}

class CarePlanStoreManager : NSObject {
    // Reference to the delegate
    weak var delegate: CarePlanStoreManagerDelegate?
    
    // Care Plan Store constant
    let store: OCKCarePlanStore
    
    // Insights
    var insights: [OCKInsightItem] {
        return insightsBuilder.insights
    }
    private let insightsBuilder: InsightsBuilder
    
    
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
        self._clearStore()
    }
    
    func updateInsights() {
        insightsBuilder.updateInsights { [weak self] completed, newInsights in
            // If new insights have been created, notifiy the delegate.
            guard let storeManager = self, let newInsights = newInsights, completed else { return }
            storeManager.delegate?.carePlanStoreManager(storeManager, didUpdateInsights: newInsights)
        }
    }
    
    
    // MARK: - Helpers
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
}

extension CarePlanStoreManager: OCKCarePlanStoreDelegate {
    func carePlanStoreActivityListDidChange(_ store: OCKCarePlanStore) {
        updateInsights()
    }
    
    func carePlanStore(_ store: OCKCarePlanStore, didReceiveUpdateOf event: OCKCarePlanEvent) {
        updateInsights()
    }
}
