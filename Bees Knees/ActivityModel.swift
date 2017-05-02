//
//  ActivityModel.swift
//  Bees Knees
//
//  Created by Kranthi Vallamreddy on 4/26/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import Gloss


struct ActivityModel: Glossy, GlossModel {
    
    let type: String
    let title: String
    let instructions: String
    let rationale: String
    let repetitionsText: String
    let bubbles: String
    let image: String
    let video: String
    
    init(json: JSON) {
        self.type = ("type" <~~ json)!
        self.title = ("title" <~~ json)!
        self.instructions = ("instructions" <~~ json)!
        self.rationale = ("rationale" <~~ json)!
        self.repetitionsText = ("repetitionsText" <~~ json)!
        self.bubbles = ("bubbles" <~~ json)!
        self.image = ("image" <~~ json)!
        self.video = ("video" <~~ json)!
        
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "type" ~~> self.type,
            "title" ~~> self.title,
            "instructions" ~~> self.instructions,
            "rationale" ~~> self.rationale,
            "repetitionsText" ~~> self.repetitionsText,
            "bubbles" ~~> self.bubbles,
            "image" ~~> self.image,
            "video" ~~> self.video
            ])
    }
}

