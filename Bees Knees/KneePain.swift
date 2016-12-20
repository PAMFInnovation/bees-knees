//
//  KneePain.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/28/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import CareKit
import ResearchKit


struct KneePain: Assessment {
    
    let activityType: ActivityType = .KneePain
    
    
    func carePlanActivity() -> OCKCarePlanActivity {
        // Create a weekly schedule.
        let startDate = DateComponents(year: 2016, month: 11, day: 01)
        let schedule = OCKCareSchedule.weeklySchedule(withStartDate: startDate as DateComponents, occurrencesOnEachDay: [1, 1, 1, 1, 1, 1, 1])
        
        // Get the localized strings to use for the assessment.
        let title = NSLocalizedString("Knee Pain", comment: "")
        
        let activity = OCKCarePlanActivity.assessment(withIdentifier: activityType.rawValue, groupIdentifier: nil, title: title, text: nil, tintColor: UIColor(red: 0x8D / 255.0, green: 0xC6 / 255.0, blue: 0x3F / 255.0, alpha: 1.0), resultResettable: false, schedule: schedule, userInfo: nil)
        
        return activity
    }
    
    
    func task() -> ORKTask {
        // Get the localized strings to use for the task.
        let question = NSLocalizedString("On a scale from 1 to 10, how would you rate your knee pain today?", comment: "")
        let maximumValueDescription = NSLocalizedString("            Good", comment: "")
        let minimumValueDescription = NSLocalizedString("Bad            ", comment: "")
        
        // Create a question and answer format.
        let answerFormat = ORKScaleAnswerFormat(maximumValue: 10, minimumValue: 1, defaultValue: -1, step: 1, vertical: false, maximumValueDescription: maximumValueDescription, minimumValueDescription: minimumValueDescription)
        
        let questionStep = ORKQuestionStep(identifier: activityType.rawValue, title: question, answer: answerFormat)
        questionStep.isOptional = false
        
        // Create an ordered task with a single question.
        let task = ORKOrderedTask(identifier: activityType.rawValue, steps: [questionStep])
        
        return task
    }
}
