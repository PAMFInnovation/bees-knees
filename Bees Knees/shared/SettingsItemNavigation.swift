//
//  SettingsItemNavigation.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 1/12/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import Foundation


class SettingsItemNavigation: SettingsItem {
    
    // Header text to display on the page
    var header: String = ""
    
    // Icon for the cell
    var icon: String = ""
    
    // Class name of the view controller to navigate to
    var className: String = ""
    
    
    init(name: String, header: String, icon: String, className: String) {
        super.init(name: name, type: .Navigation)
        
        self.header = header
        self.icon = icon
        self.className = className
    }
}
