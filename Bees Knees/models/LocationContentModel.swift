//
//  LocationContentModel.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 3/25/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import Gloss


struct LocationContentModel: Glossy, GlossModel {
    
    let appointments: [AppointmentModel]
    let activities: [ActivityModel]
    let checklist: [String]
    let binder: [BinderSectionModel]
    let faq: [FAQModel]
    let planTo: [PlanToModel]
    
    init(json: JSON) {
        self.appointments = ("appointments" <~~ json)!
        self.activities = ("activities" <~~ json)!
        self.checklist = ("checklist" <~~ json)!
        self.binder = ("binder" <~~ json)!
        self.faq = ("faq" <~~ json)!
        self.planTo = ("planto" <~~ json)!
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "appointments" ~~> self.appointments,
            "activities" ~~> self.activities,
            "checklist" ~~> self.checklist,
            "binder" ~~> self.binder,
            "faq" ~~> self.faq,
            "planto" ~~> self.planTo
        ])
    }
}
