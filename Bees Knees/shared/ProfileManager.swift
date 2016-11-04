//
//  ProfileManager.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 10/26/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import Foundation


class ProfileManager {
    // Singleton
    static let sharedInstance = ProfileManager()
    private init() {}
    
    // Personal data
    var name: String = ""
    var email: String = ""
    var phone: String = ""
    
    // Goal
    var goal: String = ""
    
    // Date of surgery
    var surgeryDate: Date?
    
    // Notes
    var notes: String = ""
}
