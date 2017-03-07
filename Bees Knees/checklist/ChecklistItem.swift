//
//  ChecklistItem.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/2/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import Foundation
import RealmSwift


final class ChecklistItem: Object {
    
    dynamic var text: String = ""
    dynamic var enabled: Bool = true
    dynamic var completed: Bool = false
    
    
    convenience init(text: String) {
        self.init()
        
        self.text = text
        self.enabled = true
        self.completed = false
    }
}
