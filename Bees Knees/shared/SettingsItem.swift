//
//  SettingsItem.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/4/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import Foundation


class SettingsItem: NSObject {
    
    // Name of the cell
    var name: String!
    
    // Icon for the cell
    var icon: String!
    
    // Class name
    var className: String!
    
    
    init(name: String, icon: String, className: String) {
        self.name = name
        self.icon = icon
        self.className = className
    }
}
