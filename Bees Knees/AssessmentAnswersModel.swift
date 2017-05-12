//
//  ProgressTrackerAnswersModel.swift
//  Bees Knees
//
//  Created by Kranthi Vallamreddy on 5/9/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import Gloss


struct AssessmentAnswersModel: Glossy, GlossModel {
    
    let text: String
    let value: String
    
    init(json: JSON) {
        self.text = ("text" <~~ json)!
        self.value = ("value" <~~ json)!
    }
        
    func toJSON() -> JSON? {
        return jsonify([
            "text" ~~> self.text,
            "value" ~~> self.value
        ])
    }
}

