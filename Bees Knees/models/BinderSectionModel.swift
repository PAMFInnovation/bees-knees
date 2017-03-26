//
//  BinderSectionModel.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 3/26/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import Gloss


struct BinderSectionModel: Glossy, GlossModel {
    
    let section: String
    let subsections: [BinderSubsectionModel]
    
    
    init(json: JSON) {
        self.section = ("section" <~~ json)!
        self.subsections = ("subsections" <~~ json)!
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "section" ~~> self.section,
            "subsections" ~~> self.subsections
        ])
    }
}
