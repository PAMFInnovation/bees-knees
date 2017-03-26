//
//  LocationModel.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 3/26/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import Gloss


struct LocationModel: Glossy, GlossModel {
    
    let key: String
    let name: String
    
    
    init(json: JSON) {
        self.key = ("key" <~~ json)!
        self.name = ("name" <~~ json)!
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "key" ~~> self.key,
            "name" ~~> self.name
        ])
    }
}
