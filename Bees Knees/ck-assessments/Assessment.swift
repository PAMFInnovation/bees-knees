//
//  Assessment.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/8/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import CareKit
import ResearchKit


protocol Assessment: Activity {
    func task() -> ORKTask
    func buildResultForCarePlanEvent(_ event: OCKCarePlanEvent, taskResult: ORKTaskResult) -> OCKCarePlanEventResult
    func getInsightGranularity() -> [String]
}

extension Assessment {
    func buildResultForCarePlanEvent(_ event: OCKCarePlanEvent, taskResult: ORKTaskResult) -> OCKCarePlanEventResult {
        // Get the first result for the first step of the task result.
        guard let firstResult = taskResult.firstResult as? ORKStepResult, let stepResult = firstResult.results?.first else { fatalError("Unexepected task results") }
        
        // Determine what type of result should be saved.
        if let scaleResult = stepResult as? ORKScaleQuestionResult, let answer = scaleResult.scaleAnswer {
            return OCKCarePlanEventResult(valueString: answer.stringValue, unitString: "out of 10", userInfo: nil)
        }
        
        fatalError("Unexpected task result type")
    }
    
    func getInsightGranularity() -> [String] {
        return []
    }
}

enum InsightGranularity: String {
    case None
    case Week
    case Month
}
