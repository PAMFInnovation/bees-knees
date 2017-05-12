//
//  ProgressTrackerQuestionsModel.swift
//  Bees Knees
//
//  Created by Kranthi Vallamreddy on 5/9/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import Gloss


struct AssessmentQuestionsModel: Glossy, GlossModel {
    
    let type: String
    let mainText: String
    let subText: String
    let answerType: String
    let answers: [AssessmentAnswersModel]
    let answerFormat: String
    
    init(json: JSON) {
        self.type = ("type" <~~ json)!
        self.mainText = ("mainText" <~~ json)!
        self.subText = ("subText" <~~ json)!
        self.answerType = ("answerType" <~~ json)!
        self.answers = ("answers" <~~ json)!
        self.answerFormat = ("answerFormat" <~~ json)!
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "type" ~~> self.type,
            "mainText" ~~> self.mainText,
            "subText" ~~> self.subText,
            "answerType" ~~> self.answerType,
            "answers" ~~> self.answers,
            "answerFormat" ~~> self.answerFormat
        ])
    }
}
