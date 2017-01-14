//
//  SettingsItemButton.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 1/12/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import Foundation


class SettingsItemButton: SettingsItem {
    
    var action: () -> Void = {}
    
    
    init(name: String, action: @escaping () -> Void) {
        super.init(name: name, type: .Button)
        
        self.action = action
    }
}
