//
//  AnswerMatrix.swift
//  Bees Knees
//
//  Created by Kranthi Vallamreddy on 5/16/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import Gloss


struct AnswerMatrix: Glossy, GlossModel {
    
    let rawScore: String
    let intervalScore: String
    
    init(json: JSON) {
        self.rawScore = ("rawScore" <~~ json)!
        self.intervalScore = ("intervalScore" <~~ json)!
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "rawScore" ~~> self.rawScore,
            "intervalScore" ~~> self.intervalScore
            ])
    }
}


