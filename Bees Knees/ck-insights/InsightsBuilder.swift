/*
 Copyright (c) 2016, Apple Inc. All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification,
 are permitted provided that the following conditions are met:
 
 1.  Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 2.  Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation and/or
 other materials provided with the distribution.
 
 3.  Neither the name of the copyright holder(s) nor the names of any contributors
 may be used to endorse or promote products derived from this software without
 specific prior written permission. No license is granted to the trademarks of
 the copyright holders even if such marks are included in this software.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

import CareKit


protocol InsightsBuilderDelegate: class {
    func insightsBuilder(_ insightsBuilder: InsightsBuilder, didUpdateInsights insights: [OCKInsightItem])
}

class InsightsBuilder {
    
    private(set) var insights = [OCKInsightItem.emptyInsightsMessage()]
    
    private let carePlanStore: OCKCarePlanStore
    
    private let updateOperationQueue = OperationQueue()
    
    required init(carePlanStore: OCKCarePlanStore) {
        self.carePlanStore = carePlanStore
    }
    
    
    // knee pain, mood, incision pain
    
    func updateInsights(completion: ((Bool, [OCKInsightItem]?) -> Void)?) {
        // Cancel any in-progress operations.
        updateOperationQueue.cancelAllOperations()
        
        let components = DateComponents()
        var queryRangeStart:NSDateComponents?
        var queryRangeEnd:NSDateComponents?
        
        var queryActivityEventsOperations:[QueryActivityEventsOperation] = [QueryActivityEventsOperation]()
        // Create a 'BuildInsightsOperation' to create insights from the data collected by query operations.
        let buildInsightsOperation = BuildInsightsOperation()
        
        let postSurgeryDate = ProfileManager.sharedInstance.getPostSurgeryStartDate()
        
        // Create an operation to aggregate the data from query operations into the 'BuildInsightsOperation'
        let aggregateDateOperations = BlockOperation {
            for i in (0..<ProfileManager.sharedInstance.getUserLocation().assessments.count) {
                buildInsightsOperation.genericEvents[ProfileManager.sharedInstance.getUserLocation().assessments[i].type] = queryActivityEventsOperations[i].dailyEvents
            }
            
            buildInsightsOperation.postSurgeryStartDate = postSurgeryDate
        }
        
        for assessment: AssessmentModel in ProfileManager.sharedInstance.getUserLocation().assessments {
            
            if(Int(assessment.bubbles) == 1) {
                let dayDate = (Calendar.current as NSCalendar).date(byAdding: components, to: ProfileManager.sharedInstance.getPostSurgeryStartDate(), options: [])!
                // Create an operation to query for events for the previous 'Pain & Recovery' activities
                queryRangeStart = NSDateComponents(date: dayDate, calendar: Calendar.current)
                queryRangeEnd = NSDateComponents(date: Date(), calendar: Calendar.current)
            } else {
                let moodQueryDateRange = calculateQueryDateRange(CarePlanStoreManager.sharedInstance.getInsightGranularityForAssessment("Mood"))
                queryRangeStart = moodQueryDateRange.start as NSDateComponents?
                queryRangeEnd = moodQueryDateRange.end as NSDateComponents?
            }
            
            let assessmentOperation = QueryActivityEventsOperation(store: carePlanStore, activityIdentifier: assessment.type, startDate: queryRangeStart as! DateComponents, endDate: queryRangeEnd as! DateComponents)
            
            queryActivityEventsOperations.append(assessmentOperation)
            aggregateDateOperations.addDependency(assessmentOperation)
            updateOperationQueue.addOperation(assessmentOperation)
        }

        // Use the completion block of the 'BuildInsightsOperation' to store the new insights and call the completion block passed to this method.
        buildInsightsOperation.completionBlock = { [unowned buildInsightsOperation] in
            let completed = !buildInsightsOperation.isCancelled
            let newInsights = buildInsightsOperation.insights
            
            // Call the completion block on the main queue.
            OperationQueue.main.addOperation {
                if completed {
                    completion?(true, newInsights)
                }
                else {
                    completion?(false, nil)
                }
            }
        }
        // The 'BuildInsightsOperation' is dependent on the aggregate operation.
        buildInsightsOperation.addDependency(aggregateDateOperations)
        
        
        // Add all the operations to the operation queue
        updateOperationQueue.addOperations([
            aggregateDateOperations,
            buildInsightsOperation
            ], waitUntilFinished: false)
    }
    
    private func calculateQueryDateRange(_ granularity: InsightGranularity = .None) -> (start: DateComponents, end: DateComponents) {
        let calendar = Calendar.current
        let now = Date()
        
        var components = DateComponents()
        switch granularity {
        case .Month:
            components.month = -1
        case .Week:
            components.day = -6
        default:
            components.day = -6
        }
        
        let startDate = calendar.date(byAdding: components, to: now)!
        
        let queryRangeStart = NSDateComponents(date: startDate, calendar: calendar)
        let queryRangeEnd = NSDateComponents(date: now, calendar: calendar)
        
        return (start: queryRangeStart as DateComponents, end: queryRangeEnd as DateComponents)
    }
}
