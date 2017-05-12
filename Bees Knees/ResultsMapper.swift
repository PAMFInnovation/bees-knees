//
//  ResultsMapper.swift
//  Bees Knees
//
//  Created by Kranthi Vallamreddy on 5/12/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//


import Gloss


struct ResultsMapper: Glossy, GlossModel {
    
    let result: String
    let score: String
    
    init(json: JSON) {
        self.result = ("type" <~~ json)!
        self.score = ("title" <~~ json)!
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "result" ~~> self.result,
            "score" ~~> self.score
            ])
    }
}

