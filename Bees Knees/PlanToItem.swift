//
//  PlanToItem.swift
//  Bees Knees
//
//  Created by Kranthi Vallamreddy on 4/10/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//
import Foundation
import RealmSwift


final class PlanToItem: Object {
    
    dynamic var appointmentType: String = ""
    dynamic var planToItems: String = ""
    
    convenience init(appointmentType: String, planToItems: String) {
        self.init()
        
        self.appointmentType = appointmentType
        self.planToItems = planToItems
    }
}
