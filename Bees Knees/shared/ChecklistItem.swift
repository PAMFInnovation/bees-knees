//
//  ChecklistItem.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/2/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import Foundation


class ChecklistItem: NSObject {
    
    var text: String
    var enabled: Bool
    var completed: Bool
    
    
    init(text: String) {
        self.text = text
        self.enabled = true
        self.completed = false
    }
}
