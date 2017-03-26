//
//  FAQModel.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 3/25/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import Gloss


struct FAQModel: Glossy, GlossModel {
    
    let question: String
    let answer: String
    
    
    init(json: JSON) {
        self.question = ("question" <~~ json)!
        self.answer = ("answer" <~~ json)!
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "question" ~~> self.question,
            "answer" ~~> self.answer
        ])
    }
}
