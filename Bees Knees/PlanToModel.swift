//
//  PlanToModel.swift
//  Bees Knees
//
//  Created by Kranthi Vallamreddy on 4/10/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import Gloss


struct PlanToModel: Glossy, GlossModel {
    
    let appointmentType: String
    let planToItems: String
    
    
    init(json: JSON) {
        self.appointmentType = ("appointmentType" <~~ json)!
        self.planToItems = ("planToItems" <~~ json)!
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "appointmentType" ~~> self.appointmentType,
            "planToItems" ~~> self.planToItems
            ])
    }
}
