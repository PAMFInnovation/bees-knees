//
//  LocationsCollectionModel.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 3/26/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import Gloss


struct LocationsCollectionModel: Glossy, GlossModel {
    
    let locations: [LocationModel]
    
    
    init(json: JSON) {
        self.locations = ("locations" <~~ json)!
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "locations" ~~> self.locations
        ])
    }
}
