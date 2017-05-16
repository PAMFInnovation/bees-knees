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
    var answerMatrix: [AnswerMatrix]
    var unitString: String

    
    init(activityType: ActivityType, title: String, subTitle:String, instructions: String, questions: [AssessmentQuestionsModel], bubbles: String, repetitionsText: String, rationale: String, image: String, video: String, answerMatrix: [AnswerMatrix], unitString: String) {
        
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
        self.answerMatrix = answerMatrix
        self.unitString = unitString
        
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
        self.answerMatrix = []
        self.unitString = ""
    }
    
    
    func carePlanActivity() -> OCKCarePlanActivity {
        // Create a weekly schedule.
        //let startDate = NSDateComponents(date: ProfileManager.sharedInstance.getPostSurgeryStartDate(), calendar: Calendar.current)
        
        let startDate = DateComponents(year: 2016, month: 11, day: 01)
        
        // This event should only occur once a week, starting on the day this activity was accessed
        var occurrences: [Int] = [0, 0, 0, 0, 0, 0, 0]
        let currentDay = ProfileManager.sharedInstance.getPostSurgeryStartDate().dayNumberOfWeek()
        // Bubbles is the numbre of days in the week the event occurs. Current we support only 1 and 7
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
                let maximumValueDescription = NSLocalizedString("Good", comment: "")
                let minimumValueDescription = NSLocalizedString("Bad", comment: "")
                
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
        
        var value: Int = 0
        for result in taskResult.results! {
            // Get the first step result and answer
            let stepResult = (result as? ORKStepResult)?.results?.first
            
            if let stepAnswer = stepResult as? ORKChoiceQuestionResult {
                value += stepAnswer.choiceAnswers?.first as! Int
            }
            else if let scaleResult = stepResult as? ORKScaleQuestionResult, let answer = scaleResult.scaleAnswer {
                value += answer as Int
            }
            // Return the final value
            return OCKCarePlanEventResult(valueString: convertRawToPersonal(score: value), unitString: unitString, userInfo: nil)
        }
        fatalError("Unexpected task result type")
    }

    
    fileprivate func convertRawToPersonal(score: Int) -> String {
        for answerMatrix: AnswerMatrix in self.answerMatrix {
            if(Int(answerMatrix.rawScore) == score) {
                return answerMatrix.intervalScore
            }
        }
        return "0"
    }
}
