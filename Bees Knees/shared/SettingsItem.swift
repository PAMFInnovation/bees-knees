//
//  SettingsItem.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/4/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import Foundation


enum SettingsItemType: Int {
    case Default
    case Navigation
    case Button
}

class SettingsItem: NSObject {
    
    // Type of the cell
    var type: SettingsItemType = .Default
    
    // Name of the cell
    var name: String = ""
    
    
    init(name: String, type: SettingsItemType = .Default) {
        self.name = name
        self.type = type
    }
}
