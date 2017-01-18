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
    
    var kneePainEvents: DailyEvents?
    var moodEvents: DailyEvents?
    var incisionPainEvents: DailyEvents?
    
    fileprivate(set) var insights = [OCKInsightItem.emptyInsightsMessage()]
    
    
    // MARK: - Operation
    
    override func main() {
        // Do nothing if the operation has been cancelled.
        guard !isCancelled else { return }
        
        // Create an array of insights.
        var newInsights = [OCKInsightItem]()
        
        if let insight = createKneePainInsight() {
            newInsights.append(insight)
        }
        
        if let insight = createMoodInsight() {
            newInsights.append(insight)
        }
        
        if let insight = createIncisionPainInsight() {
            newInsights.append(insight)
        }
        
        // Store any new insights that we created.
        if !newInsights.isEmpty {
            insights = newInsights
        }
    }
    
    
    // MARK: - Convenience
    
    func createKneePainInsight() -> OCKInsightItem? {
        
        // Make sure there are events to parse
        guard let kneePainEvents = kneePainEvents else { return nil }
        
        // Determine the start date for the previous week
        let calendar = Calendar.current
        let now = Date()
        var components = DateComponents()
        components.day = -7
        let startDate = calendar.weekDatesForDate((calendar as NSCalendar).date(byAdding: components, to: now, options: [])!).start
        
        // Construct the plot points
        // Knee Pain, Mood, Incision Pain
        var plotPoints: [ORKValueRange] = []
        var labels: [String] = []
        
        for offset in 0..<7 {
            // Determine the day components.
            components.day = offset
            let dayDate = (calendar as NSCalendar).date(byAdding: components, to: startDate, options: [])!
            let dayComponents = NSDateComponents(date: dayDate, calendar: calendar)
            
            labels.append(Util.getFormattedDate(dayDate, dateFormat: "M/d"))
            
            // Store the knee pain result for the current day.
            if let result = kneePainEvents[dayComponents as DateComponents].first?.result, let score = Int(result.valueString), score > 0 {
                plotPoints.append(ORKValueRange(value: Double(score)))
            }
            else {
                plotPoints.append(ORKValueRange())
            }
        }
        
        // Create the line graph and set the data
        let lineGraph = LineGraphChart.init()
        lineGraph.title = "Knee Pain"
        CarePlanStoreManager.sharedInstance.insightsData[lineGraph.title!] = LineGraphDataSource(plotPoints, labels: labels)
        return lineGraph
    }
    
    func createMoodInsight() -> OCKInsightItem? {
        
        // Make sure there are events to parse
        guard let moodEvents = moodEvents else { return nil }
        
        // Determine the start date for the previous week
        let calendar = Calendar.current
        let now = Date()
        var components = DateComponents()
        components.day = -7
        let startDate = calendar.weekDatesForDate((calendar as NSCalendar).date(byAdding: components, to: now, options: [])!).start
        
        // Construct the plot points
        // Knee Pain, Mood, Incision Pain
        var plotPoints: [ORKValueRange] = []
        var labels: [String] = []
        
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
        
        // Create the line graph and set the data
        let lineGraph = LineGraphChart.init()
        lineGraph.title = "Mood"
        CarePlanStoreManager.sharedInstance.insightsData[lineGraph.title!] = LineGraphDataSource(plotPoints, labels: labels)
        return lineGraph
    }

    func createIncisionPainInsight() -> OCKInsightItem? {
        
        // Make sure there are events to parse
        guard let incisionPainEvents = incisionPainEvents else { return nil }
        
        // Determine the start date for the previous week
        let calendar = Calendar.current
        let now = Date()
        var components = DateComponents()
        components.day = -7
        let startDate = calendar.weekDatesForDate((calendar as NSCalendar).date(byAdding: components, to: now, options: [])!).start
        
        // Construct the plot points
        // Knee Pain, Mood, Incision Pain
        var plotPoints: [ORKValueRange] = []
        var labels: [String] = []
        
        for offset in 0..<7 {
            // Determine the day components.
            components.day = offset
            let dayDate = (calendar as NSCalendar).date(byAdding: components, to: startDate, options: [])!
            let dayComponents = NSDateComponents(date: dayDate, calendar: calendar)
            
            labels.append(Util.getFormattedDate(dayDate, dateFormat: "M/d"))
            
            // Store the incision pain result for the current day.
            if let result = incisionPainEvents[dayComponents as DateComponents].first?.result, let score = Int(result.valueString), score > 0 {
                plotPoints.append(ORKValueRange(value: Double(score)))
            }
            else {
                plotPoints.append(ORKValueRange())
            }
        }
        
        // Create the line graph and set the data
        let lineGraph = LineGraphChart.init()
        lineGraph.title = "Incision Pain"
        CarePlanStoreManager.sharedInstance.insightsData[lineGraph.title!] = LineGraphDataSource(plotPoints, labels: labels)
        return lineGraph
    }
}
