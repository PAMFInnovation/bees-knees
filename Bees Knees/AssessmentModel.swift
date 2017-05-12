//
//  ProgressTrackerModel.swift
//  Bees Knees
//
//  Created by Kranthi Vallamreddy on 5/9/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import Gloss


struct AssessmentModel: Glossy, GlossModel {
    
    let type: String
    let title: String
    let subTitle: String
    let bubbles: String
    let questions: [AssessmentQuestionsModel]

    
    init(json: JSON) {
        self.type = ("type" <~~ json)!
        self.title = ("title" <~~ json)!
        self.subTitle = ("subTitle" <~~ json)!
        self.bubbles = ("bubbles" <~~ json)!
        self.questions = ("questions" <~~ json)!
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "type" ~~> self.type,
            "title" ~~> self.title,
            "subTitle" ~~> self.subTitle,
            "bubble" ~~> self.bubbles,
            "questions" ~~> self.questions
            ])
    }
}
