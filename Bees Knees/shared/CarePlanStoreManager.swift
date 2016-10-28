//
//  CarePlanStoreManager.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 10/27/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import Foundation
import CareKit


class CarePlanStoreManager {
    // Care Plan Store constant
    let store: OCKCarePlanStore
    
    // Singleton
    static let sharedInstance = CarePlanStoreManager()
    private init() {
        // Set the directory URL where we'll store the care plan store
        let searchPaths = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true)
        let applicationSupportPath = searchPaths[0]
        let persistentDirectoryURL = URL(fileURLWithPath: applicationSupportPath)
        
        if !FileManager.default.fileExists(atPath: persistentDirectoryURL.absoluteString, isDirectory: nil) {
            try! FileManager.default.createDirectory(at: persistentDirectoryURL, withIntermediateDirectories: true, attributes: nil)
        }
        
        // Create the care plan store
        store = OCKCarePlanStore(persistenceDirectoryURL: persistentDirectoryURL)
        
        // TEMP: clear the store each time the app is run
        self._clearStore()
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
