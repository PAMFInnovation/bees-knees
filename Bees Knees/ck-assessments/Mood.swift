//
//  Mood.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/8/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import CareKit
import ResearchKit


struct Mood: Assessment {
    var activityType: ActivityType
    
    var title: String
    var instructions: String
    var repetitionsText: String
    var bubbles: String
    var rationale: String
    var image: String
    var video: String
    
    init(activityType: ActivityType, title: String, instructions: String, repetitionsText: String, bubbles: String, rationale: String, image: String, video: String) {
        self.activityType = activityType
        self.title = title
        self.instructions = instructions
        self.repetitionsText = repetitionsText
        self.bubbles = bubbles
        self.rationale = rationale
        self.image = image
        self.video = video
    }
    
    func carePlanActivity() -> OCKCarePlanActivity {
        // Create a weekly schedule.
        let startDate = DateComponents(year: 2016, month: 11, day: 01)
        let schedule = OCKCareSchedule.weeklySchedule(withStartDate: startDate as DateComponents, occurrencesOnEachDay: [1, 1, 1, 1, 1, 1, 1])
        
        // Get the localized strings to use for the assessment.
        let title = NSLocalizedString("Mood", comment: "")
        
        let activity = OCKCarePlanActivity.assessment(
            withIdentifier: activityType.rawValue,
            groupIdentifier: nil,
            title: title,
            text: nil,
            tintColor: UIColor(red: 0x8D / 255.0, green: 0xC6 / 255.0, blue: 0x3F / 255.0, alpha: 1.0),
            resultResettable: true,
            schedule: schedule,
            userInfo: nil
        )
        
        return activity
    }
    
    func task() -> ORKTask {
        // Get the localized strings to use for the task.
        let question = NSLocalizedString("On a scale from 1 to 10, how would you rate your mood today?", comment: "")
        let maximumValueDescription = NSLocalizedString("            Good", comment: "")
        let minimumValueDescription = NSLocalizedString("Bad            ", comment: "")
        
        // Create a question and answer format.
        let answerFormat = ORKScaleAnswerFormat(
            maximumValue: 10,
            minimumValue: 1,
            defaultValue: -1,
            step: 1,
            vertical: false,
            maximumValueDescription: maximumValueDescription,
            minimumValueDescription: minimumValueDescription
        )
        
        let questionStep = ORKQuestionStep(identifier: activityType.rawValue, title: question, answer: answerFormat)
        questionStep.isOptional = false
        
        // Create an ordered task with a single question.
        let task = ORKOrderedTask(identifier: activityType.rawValue, steps: [questionStep])
        
        return task
    }
    
    func getInsightGranularity() -> [String] {
        return [InsightGranularity.Week.rawValue, InsightGranularity.Month.rawValue]
    }
}
