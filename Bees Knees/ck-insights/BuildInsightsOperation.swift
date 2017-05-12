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
import ResearchKit


class BuildInsightsOperation: Operation {
    
    // MARK: - Properties
    
    var recoveryEvents: DailyEvents?
    var moodEvents: DailyEvents?
    
    var events: [DailyEvents]?
    
    var postSurgeryStartDate: Date?
    
    fileprivate(set) var insights = [OCKInsightItem.emptyInsightsMessage()]
    
    
    // MARK: - Operation
    
    override func main() {
        // Do nothing if the operation has been cancelled.
        guard !isCancelled else { return }
        
        // Create an array of insights.
        var newInsights = [OCKInsightItem]()
        
        
        
        if(ProfileManager.sharedInstance.userLocation != nil) {
            let location = ProfileManager.sharedInstance.getUserLocation()
            for assessment in location.assessments {
                if(assessment.title == "Pain & Recovery") {
                    if let insight = createGenericInsight(assessment: assessment) {
                        newInsights.append(insight)
                    }
                } else {
                    if let insight = createMoodInsight() {
                        newInsights.append(insight)
                    }
                }
                
            }
        }
        
//        if let insight = createMoodInsight() {
//            newInsights.append(insight)
//        }
        
        // Store any new insights that we created.
        if !newInsights.isEmpty {
            insights = newInsights
        }
    }
    
    
    func createGenericInsight(assessment:AssessmentModel) -> OCKInsightItem? {
        
        // Make sure there are events to parse
        guard let recoveryEvents = recoveryEvents else { return nil }
        
        // Only proceed if the patient is in post surgery
        guard let postSurgeryStartDate = postSurgeryStartDate else { return nil }
        
        // Determine the start date for the previous week
        let calendar = Calendar.current
        var components = DateComponents()
        components.day = 0
        var currentDate = calendar.date(byAdding: components, to: postSurgeryStartDate)!
        
        
        // Construct the plot points
        var plotPoints: [ORKValueRange] = []
        var labels: [String] = []
        
        // Iterate until we have all dates, ensuring we don't go beyond "today"
        var dayComponents = NSDateComponents(date: currentDate, calendar: calendar)
        while currentDate < Date() {
            // Get the result and append scores to the plot
            if let result = recoveryEvents[dayComponents as DateComponents].first?.result, let score = Double(result.valueString), score > 0 {
                plotPoints.append(ORKValueRange(value: Double(score)))
            }
            else {
                plotPoints.append(ORKValueRange())
            }
            
            // Append labels to the plot
            labels.append(Util.getFormattedDate(currentDate, dateFormat: "M/d"))
            
            // Increment the date by 1 week
            components.day = components.day! + 7
            currentDate = calendar.date(byAdding: components, to: postSurgeryStartDate)!
            dayComponents = NSDateComponents(date: currentDate, calendar: calendar)
        }
        
        // Create the line graph and set the data
        let lineGraph = LineGraphChart.init()
        lineGraph.title = assessment.title
        CarePlanStoreManager.sharedInstance.insightsData[lineGraph.title!] = (LineGraphDataSource(plotPoints, labels: labels, valueRange: (0, 100)), CarePlanStoreManager.sharedInstance.getInsightGranularityForAssessment(lineGraph.title!))
        return lineGraph
    }

    
    
    // MARK: - Convenience
    
    func createRecoveryInsight() -> OCKInsightItem? {
        // Make sure there are events to parse
        guard let recoveryEvents = recoveryEvents else { return nil }
        
        // Only proceed if the patient is in post surgery
        guard let postSurgeryStartDate = postSurgeryStartDate else { return nil }
        
        // Determine the start date for the previous week
        let calendar = Calendar.current
        var components = DateComponents()
        components.day = 0
        var currentDate = calendar.date(byAdding: components, to: postSurgeryStartDate)!
        
        let now = Date()
        
        // Construct the plot points
        var plotPoints: [ORKValueRange] = []
        var labels: [String] = []
        
        // Iterate until we have all dates, ensuring we don't go beyond "today"
       // var dayComponents = NSDateComponents(date: currentDate, calendar: calendar)
        while currentDate < Date() {
            components.day = -6
            currentDate = calendar.date(byAdding: components, to: postSurgeryStartDate)!
            let startDate = calendar.date(byAdding: components, to: now)!
            
            let dayDate = (calendar as NSCalendar).date(byAdding: components, to: startDate, options: [])!
            let dayComponents = NSDateComponents(date: dayDate, calendar: calendar)
            // Get the result and append scores to the plot
            if let result = recoveryEvents[dayComponents as DateComponents].first?.result, let score = Double(result.valueString), score > 0 {
                plotPoints.append(ORKValueRange(value: Double(score)))
            }
            else {
                plotPoints.append(ORKValueRange())
            }
            
            // Append labels to the plot
            labels.append(Util.getFormattedDate(currentDate, dateFormat: "M/d"))
            
        }
        
        // Create the line graph and set the data
        let lineGraph = LineGraphChart.init()
        lineGraph.title = "Pain & Recovery"
        CarePlanStoreManager.sharedInstance.insightsData[lineGraph.title!] = (LineGraphDataSource(plotPoints, labels: labels, valueRange: (0, 100)), CarePlanStoreManager.sharedInstance.getInsightGranularityForAssessment(lineGraph.title!))
        return lineGraph
    }
    
    func createMoodInsight() -> OCKInsightItem? {
        
        // Make sure there are events to parse
        guard let moodEvents = moodEvents else { return nil }
        
        // Determine the start date for the previous week
        let calendar = Calendar.current
        let now = Date()
        var components = DateComponents()
        
        // Construct the plot points
        var plotPoints: [ORKValueRange] = []
        var labels: [String] = []
        
        if (CarePlanStoreManager.sharedInstance.getInsightGranularityForAssessment("Mood").rawValue == "Month"){
            let dateComponents = DateComponents(year: calendar.component(.year, from: now), month: calendar.component(.month, from: now)-1)
            let calendar = Calendar.current
            let date = calendar.date(from: dateComponents)!
            
            let range = calendar.range(of: .day, in: .month, for: date)!
            let numDays = range.count
            
            components.day = -numDays + 1
            //let startDate = calendar.weekDatesForDate((calendar as NSCalendar).date(byAdding: components, to: now, options: [])!).start
            let startDate = calendar.date(byAdding: components, to: now)!
            
            var dayDate = (calendar as NSCalendar).date(byAdding: components, to: startDate, options: [])!
            for offset in 0..<numDays {
                // Determine the day components.
                components.day = offset
                dayDate = (calendar as NSCalendar).date(byAdding: components, to: startDate, options: [])!
                let dayComponents = NSDateComponents(date: dayDate, calendar: calendar)
                if offset%10 == 0 {
                    labels.append(Util.getFormattedDate(dayDate, dateFormat: "M/d"))
                } else {
                    labels.append("")
                }
                // Store the mood result for the current day.
                if let result = moodEvents[dayComponents as DateComponents].first?.result, let score = Int(result.valueString), score > 0 {
                    plotPoints.append(ORKValueRange(value: Double(score)))
                }
                else {
                    plotPoints.append(ORKValueRange())
                }
            }
            labels.removeLast()
            labels.append(Util.getFormattedDate(dayDate, dateFormat: "M/d"))
        }
        else {
            components.day = -6
            //let startDate = calendar.weekDatesForDate((calendar as NSCalendar).date(byAdding: components, to: now, options: [])!).start
            let startDate = calendar.date(byAdding: components, to: now)!
            
            
            for offset in 0..<7 {
                // Determine the day components.
                components.day = offset
                let dayDate = (calendar as NSCalendar).date(byAdding: components, to: startDate, options: [])!
                let dayComponents = NSDateComponents(date: dayDate, calendar: calendar)
                labels.append(Util.getFormattedDate(dayDate, dateFormat: "M/d"))
                
                // Store the mood result for the current day.
                if let result = moodEvents[dayComponents as DateComponents].first?.result, let score = Int(result.valueString), score > 0 {
                    plotPoints.append(ORKValueRange(value: Double(score)))
                }
                else {
                    plotPoints.append(ORKValueRange())
                }
            }
        }
        
        
        
        
        // Create the line graph and set the data
        let lineGraph = LineGraphChart.init()
        lineGraph.title = "Mood"
        CarePlanStoreManager.sharedInstance.insightsData[lineGraph.title!] = (LineGraphDataSource(plotPoints, labels: labels), CarePlanStoreManager.sharedInstance.getInsightGranularityForAssessment(lineGraph.title!))
        return lineGraph
    }
    
}
