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
            return "92.0"
        case 26:
            return "84.6"
        case 25:
            return "80.0"
        case 24:
            return "76.3"
        case 23:
            return "73.3"
        case 22:
            return "70.7"
        case 21:
            return "68.3"
        case 20:
            return "66.0"
        case 19:
            return "63.8"
        case 18:
            return "61.6"
        case 17:
            return "59.4"
        case 16:
            return "57.1"
        case 15:
            return "54.8"
        case 14:
            return "52.5"
        case 13:
            return "50.0"
        case 12:
            return "47.5"
        case 11:
            return "45.0"
        case 10:
            return "42.3"
        case 9:
            return "39.6"
        case 8:
            return "37.0"
        case 7:
            return "34.2"
        case 6:
            return "31.3"
        case 5:
            return "28.3"
        case 4:
            return "24.9"
        case 3:
            return "21.0"
        case 2:
            return "16.0"
        case 1:
            return "8.3"
        case 0:
            return "0"
        default:
            return "0"
        }
    }
}
