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
    
    // Class name of the view controller to navigate to
    var className: String = ""
    
    
    init(name: String, header: String, icon: String, className: String) {
        super.init(name: name, icon: icon, type: .Navigation)
        
        self.header = header
        self.className = className
    }
}
