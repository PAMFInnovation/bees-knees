//
//  Recovery.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 2/6/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import CareKit
import ResearchKit


struct Recovery: Assessment {
    let activityType: ActivityType = .Recovery
    
    let rationale: String = NSLocalizedString("", comment: "")
    let image: (name: String, type: String) = ("", "")
    let video: (name: String, type: String) = ("", "")
    
    
    func carePlanActivity() -> OCKCarePlanActivity {
        // Create a weekly schedule.
        let startDate = NSDateComponents(date: ProfileManager.sharedInstance.getPostSurgeryStartDate(), calendar: Calendar.current)
        
        var components = DateComponents()
        let dayDate = (Calendar.current as NSCalendar).date(byAdding: components, to: ProfileManager.sharedInstance.getPostSurgeryStartDate(), options: [])!
        let dayComponents = NSDateComponents(date: dayDate, calendar: Calendar.current)
        
        // This event should only occur once a week, starting on the day this activity was accessed
        var occurrences: [NSNumber] = [0, 0, 0, 0, 0, 0, 0]
        let currentDay = ProfileManager.sharedInstance.getPostSurgeryStartDate().dayNumberOfWeek()
        occurrences[currentDay! - 1] = 1
        
        let schedule = OCKCareSchedule.weeklySchedule(withStartDate: dayComponents as DateComponents, occurrencesOnEachDay: occurrences)
        
        // Get the localized strings to use for the assessment.
        let title = NSLocalizedString("Pain & Recovery", comment: "")
        let text = NSLocalizedString("Weekly score: 0-100, 100 = no issues", comment: "")
        
        let activity = OCKCarePlanActivity.assessment(withIdentifier: activityType.rawValue, groupIdentifier: nil, title: title, text: text, tintColor: UIColor(red: 0x8D / 255.0, green: 0xC6 / 255.0, blue: 0x3F / 255.0, alpha: 1.0), resultResettable: true, schedule: schedule, userInfo: nil)
        
        return activity
    }
    
    func task() -> ORKTask {
        // Get the localized strings to use for the task.
        let prompts: [(String, String, String)] = [
            (NSLocalizedString("The following question concerns the amount of joint stiffness you have experienced during the last week in your knee. Stiffness is a sensation of restriction or slowness in the ease with which you move your knee joint.", comment: ""), NSLocalizedString("How severe is your knee stiffness after first wakening in the morning?", comment: ""), "stiffness"),
            (NSLocalizedString("What amount of knee pain have you experienced the last week during the following activities?", comment: ""), NSLocalizedString("Twisting/pivoting on your knee", comment: ""), "twisting"),
            (NSLocalizedString("What amount of knee pain have you experienced the last week during the following activities?", comment: ""), NSLocalizedString("Straightening knee fully", comment: ""), "straightening-knee"),
            (NSLocalizedString("What amount of knee pain have you experienced the last week during the following activities?", comment: ""), NSLocalizedString("Going up or down stairs", comment: ""), "stairs"),
            (NSLocalizedString("What amount of knee pain have you experienced the last week during the following activities?", comment: ""), NSLocalizedString("Standing upright", comment: ""), "standing-upright"),
            (NSLocalizedString("The following questions concern your physical function. By this we mean your ability to move around and to look after yourself. For each of the following activities please indicate the degree of difficulty you have experienced in the last week due to your knee.", comment: ""), NSLocalizedString("Rising from sitting", comment: ""), "rising-from-sitting"),
            (NSLocalizedString("The following questions concern your physical function. By this we mean your ability to move around and to look after yourself. For each of the following activities please indicate the degree of difficulty you have experienced in the last week due to your knee.", comment: ""), NSLocalizedString("Bending to floor/pick up an object", comment: ""), "bending")
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
            let questionStep = ORKQuestionStep(identifier: prompt.2, title: prompt.1, text: prompt.0, answer: answerFormat)
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
        case 28:
            return "100"
        case 27:
            return "91.975"
        case 26:
            return "84.6"
        case 25:
            return "79.914"
        case 24:
            return "76.332"
        case 23:
            return "73.342"
        case 22:
            return "70.704"
        case 21:
            return "68.284"
        case 20:
            return "65.994"
        case 19:
            return "63.776"
        case 18:
            return "61.583"
        case 17:
            return "59.381"
        case 16:
            return "57.140"
        case 15:
            return "54.840"
        case 14:
            return "52.465"
        case 13:
            return "50.012"
        case 12:
            return "47.487"
        case 11:
            return "44.905"
        case 10:
            return "42.281"
        case 9:
            return "39.625"
        case 8:
            return "36.931"
        case 7:
            return "34.174"
        case 6:
            return "31.307"
        case 5:
            return "28.251"
        case 4:
            return "24.875"
        case 3:
            return "20.941"
        case 2:
            return "15.939"
        case 1:
            return "8.291"
        case 0:
            return "0"
        default:
            return "0"
        }
    }
}
