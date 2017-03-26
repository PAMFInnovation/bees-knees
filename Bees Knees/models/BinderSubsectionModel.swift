//
//  BinderSubsectionModel.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 3/26/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import Gloss


struct BinderSubsectionModel: Glossy, GlossModel {
    
    let title: String
    let file: String
    
    
    init(json: JSON) {
        self.title = ("title" <~~ json)!
        self.file = ("file" <~~ json)!
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "title" ~~> self.title,
            "file" ~~> self.file
        ])
    }
}
