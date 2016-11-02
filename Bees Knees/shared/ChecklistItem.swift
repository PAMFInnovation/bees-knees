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
    var completed: Bool
    
    
    init(text: String) {
        self.text = text
        self.completed = false
    }
}
