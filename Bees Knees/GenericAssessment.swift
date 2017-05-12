//
//  GenericAssessment.swift
//  Bees Knees
//
//  Created by Kranthi Vallamreddy on 5/8/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//


import CareKit
import ResearchKit


struct GenericAssessment: Assessment {
    
    var activityType: ActivityType
    
    var title: String
    var subTitle: String
    var instructions: String
    var repetitionsText: String
    var bubbles: String
    var rationale: String
    var image: String
    var video: String
    
    var questions: [AssessmentQuestionsModel]

    
    init(activityType: ActivityType, title: String, subTitle:String, instructions: String, questions: [AssessmentQuestionsModel], bubbles: String, repetitionsText: String, rationale: String, image: String, video: String) {
        
        self.activityType = activityType
        self.title = title
        self.subTitle = subTitle
        self.instructions = instructions
        self.bubbles = bubbles
        self.repetitionsText = ""
        self.rationale = ""
        self.image = ""
        self.video = ""
        self.questions = questions
        
    }
    
    init(activityType: ActivityType, title: String, instructions: String, repetitionsText: String, bubbles: String, rationale: String, image: String, video: String) {
        self.activityType = activityType
        self.title = title
        self.instructions = instructions
        self.repetitionsText = repetitionsText
        self.bubbles = bubbles
        self.rationale = rationale
        self.image = image
        self.video = video
        self.questions = []
        self.subTitle = ""
    }
    
    
    func carePlanActivity() -> OCKCarePlanActivity {
        // Create a weekly schedule.
        //let startDate = NSDateComponents(date: ProfileManager.sharedInstance.getPostSurgeryStartDate(), calendar: Calendar.current)
        
        let startDate = DateComponents(year: 2016, month: 11, day: 01)
        
        // This event should only occur once a week, starting on the day this activity was accessed
        var occurrences: [Int] = [0, 0, 0, 0, 0, 0, 0]
        let currentDay = ProfileManager.sharedInstance.getPostSurgeryStartDate().dayNumberOfWeek()
        if(Int(self.bubbles)! == 1) {
            occurrences[currentDay! - 1] =  Int(self.bubbles)!
        } else {
            occurrences = [1, 1, 1, 1, 1, 1, 1]
        }
        
        let schedule = OCKCareSchedule.weeklySchedule(withStartDate: startDate as DateComponents, occurrencesOnEachDay: occurrences as [NSNumber])
        
        // Get the localized strings to use for the assessment.
        let title = NSLocalizedString(self.title, comment: "")
        let text = NSLocalizedString(self.subTitle, comment: "")
        
        let activity = OCKCarePlanActivity.assessment(withIdentifier: activityType.rawValue, groupIdentifier: nil, title: title, text: text, tintColor: UIColor(red: 0x8D / 255.0, green: 0xC6 / 255.0, blue: 0x3F / 255.0, alpha: 1.0), resultResettable: true, schedule: schedule, userInfo: nil)
        
        return activity
    }
    
    func task() -> ORKTask {
        
        var questions: [ORKQuestionStep] = []
        
        // Iterate through the prompts and create question steps for each
        //use questions array
        for question in self.questions {
            
            var answerChoices: [(ORKTextChoice)] =  [(ORKTextChoice)]()
            
            for answer in question.answers {
                answerChoices.append(ORKTextChoice(text: answer.text, value: Int(answer.value) as! NSCoding & NSCopying & NSObjectProtocol))
            }
            
            if(question.answerFormat == "text") {
                let answerFormat = ORKTextChoiceAnswerFormat(style: .singleChoice, textChoices: answerChoices)
                // Question
                let questionStep = ORKQuestionStep(identifier: question.type, title: question.mainText, text: question.subText, answer: answerFormat)
                questionStep.isOptional = false
                questions.append(questionStep)
            } else if(question.answerFormat == "scale") {
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
                
                let questionStep = ORKQuestionStep(identifier: question.type, title: question.mainText, answer: answerFormat)
                questionStep.isOptional = false
                questions.append(questionStep)
            }
        }
        
        // Create an ordered task with the questions
        let task = ORKOrderedTask(identifier: activityType.rawValue, steps: questions)
        return task
        
    }

    func getInsightGranularity() -> [String] {
        return [InsightGranularity.Week.rawValue, InsightGranularity.Month.rawValue]
    }

    func buildResultForCarePlanEvent(_ event: OCKCarePlanEvent, taskResult: ORKTaskResult) -> OCKCarePlanEventResult {
        // Itereate through the results and get the first step result in each
        
        if(event.activity.title == "Pain & Recovery") {
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
        } else {
            // Get the first result for the first step of the task result.
            guard let firstResult = taskResult.firstResult as? ORKStepResult, let stepResult = firstResult.results?.first else { fatalError("Unexepected task results") }
            
            // Determine what type of result should be saved.
            if let scaleResult = stepResult as? ORKScaleQuestionResult, let answer = scaleResult.scaleAnswer {
                return OCKCarePlanEventResult(valueString: answer.stringValue, unitString: "out of 10", userInfo: nil)
            }

        }
        fatalError("Unexpected task result type")
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
