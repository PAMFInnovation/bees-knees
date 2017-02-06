//
//  DailyRoutine.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 2/6/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import CareKit
import ResearchKit


struct DailyRoutine: Assessment {
    let activityType: ActivityType = .DailyRoutine
    
    let rationale: String = NSLocalizedString("", comment: "")
    let image: (name: String, type: String) = ("", "")
    let video: (name: String, type: String) = ("", "")
    
    
    func carePlanActivity() -> OCKCarePlanActivity {
        // Create a weekly schedule.
        let startDate = DateComponents(year: 2016, month: 11, day: 01)
        let schedule = OCKCareSchedule.weeklySchedule(withStartDate: startDate as DateComponents, occurrencesOnEachDay: [1, 1, 1, 1, 1, 1, 1])
        
        // Get the localized strings to use for the assessment.
        let title = NSLocalizedString("Daily Routine", comment: "")
        
        let activity = OCKCarePlanActivity.assessment(withIdentifier: activityType.rawValue, groupIdentifier: nil, title: title, text: nil, tintColor: UIColor(red: 0x8D / 255.0, green: 0xC6 / 255.0, blue: 0x3F / 255.0, alpha: 1.0), resultResettable: true, schedule: schedule, userInfo: nil)
        
        return activity
    }
    
    
    func task() -> ORKTask {
        // Get the localized strings to use for the task.
        let question = NSLocalizedString("Please indicate the degree of difficulty you have experienced in the last week due to your surgical knee:", comment: "")
        let prompts: [(String, String)] = [
            (NSLocalizedString("Rising from bed", comment: ""), "rising-from-bed"),
            (NSLocalizedString("Putting on socks/stockings", comment: ""), "putting-on-socks"),
            (NSLocalizedString("Rising from sitting", comment: ""), "rising-from-sitting"),
            (NSLocalizedString("Bending to floor", comment: ""), "bending-to-floor"),
            (NSLocalizedString("Twisting/pivoting on your surgical knee", comment: ""), "twisting-and-pivoting"),
            (NSLocalizedString("Kneeling", comment: ""), "kneeling"),
            (NSLocalizedString("Squatting", comment: ""), "squatting")
        ]
        let answerChoices = [
            ORKTextChoice(text: "None", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Mild", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Moderate", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Severe", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Extreme", value: 0 as NSCoding & NSCopying & NSObjectProtocol)
        ]
        var questions: [ORKQuestionStep] = []
        
        // Iterate through the prompts and create question steps for each
        for prompt in prompts {
            // Answer
            let answerFormat = ORKTextChoiceAnswerFormat(style: .singleChoice, textChoices: answerChoices)
            
            // Question
            let questionStep = ORKQuestionStep(identifier: prompt.1, title: question, text: prompt.0, answer: answerFormat)
            questionStep.isOptional = false
            questions.append(questionStep)
        }
        
        // Create an ordered task with the questions
        let task = ORKOrderedTask(identifier: activityType.rawValue, steps: questions)
        return task
    }
    
    func buildResultForCarePlanEvent(_ event: OCKCarePlanEvent, taskResult: ORKTaskResult) -> OCKCarePlanEventResult {
        // Itereate through the results and get the first step result in each
        var value: Int = 0
        for result in taskResult.results! {
            // Get the first step result and answer
            let stepResult = (result as? ORKStepResult)?.results?.first
            let stepAnswer = (stepResult as? ORKChoiceQuestionResult)?.choiceAnswers?.first
            
            // Accumulate those answers into one value
            value += (stepAnswer as! Int)
        }
        
        // Return the final value
        return OCKCarePlanEventResult(valueString: convertRawToPersonal(score: value), unitString: "out of 100", userInfo: nil)
    }
    
    fileprivate func convertRawToPersonal(score: Int) -> String {
        switch score {
        case 0:
            return "100"
        case 1:
            return "94.4"
        case 2:
            return "89.5"
        case 3:
            return "85.2"
        case 4:
            return "81.4"
        case 5:
            return "78"
        case 6:
            return "75.1"
        case 7:
            return "72.5"
        case 8:
            return "70.3"
        case 9:
            return "68.2"
        case 10:
            return "66.4"
        case 11:
            return "64.7"
        case 12:
            return "63"
        case 13:
            return "61.4"
        case 14:
            return "59.7"
        case 15:
            return "58"
        case 16:
            return "56"
        case 17:
            return "53.9"
        case 18:
            return "51.5"
        case 19:
            return "48.8"
        case 20:
            return "45.6"
        case 21:
            return "42.1"
        case 22:
            return "38"
        case 23:
            return "33.4"
        case 24:
            return "28.2"
        case 25:
            return "22.3"
        case 26:
            return "15.7"
        case 27:
            return "8.2"
        case 28:
            return "0"
        default:
            return "0"
        }
    }
}
