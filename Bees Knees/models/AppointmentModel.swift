//
//  AppointmentModel.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 3/26/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import Gloss


struct AppointmentModel: Glossy, GlossModel {
    
    let title: String
    let type: String
    
    
    init(json: JSON) {
        self.title = ("title" <~~ json)!
        self.type = ("type" <~~ json)!
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "title" ~~> self.title,
            "type" ~~> self.type
        ])
    }
}
