//
//  PlanToItem.swift
//  Bees Knees
//
//  Created by Kranthi Vallamreddy on 4/5/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import Foundation
import RealmSwift


final class PlanToItem: Object {
    
    dynamic var appointmentType: String = ""
    dynamic var planToItems: String = ""
    
    convenience init(text: String, planTo: String) {
        self.init()
        self.appointmentType = text
        self.planToItems = planTo
    }
}
