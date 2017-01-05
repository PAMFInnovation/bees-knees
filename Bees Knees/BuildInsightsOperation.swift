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
        
        if let insight = createPrimaryInsight() {
            newInsights.append(insight)
        }
        
        // Store any new insights that we created.
        if !newInsights.isEmpty {
            insights = newInsights
        }
    }
    
    
    // MARK: - Convenience
    
    func createPrimaryInsight() -> OCKInsightItem? {
        // Make sure there are events to parse
        guard let kneePainEvents = kneePainEvents, let moodEvents = moodEvents, let incisionPainEvents = incisionPainEvents else { return nil }
        
        // Determine the start date for the previous week
        let calendar = Calendar.current
        let now = Date()
        var components = DateComponents()
        components.day = -7
        let startDate = calendar.weekDatesForDate((calendar as NSCalendar).date(byAdding: components, to: now, options: [])!).start
        
        // Create the formatters for the barchart data
        let dayOfWeekFormatter = DateFormatter()
        dayOfWeekFormatter.dateFormat = "E"
        let shortDateFormatter = DateFormatter()
        shortDateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "Md", options: 0, locale: shortDateFormatter.locale)
        
        // Loop through the week, collecting pain and mood scores
        var kneePainValues = [Int]()
        var moodValues = [Int]()
        var incisionPainValues = [Int]()
        
        // Labels
        var kneePainLabels = [String]()
        var moodLabels = [String]()
        var incisionPainLabels = [String]()
        var axisTitles = [String]()
        var axisSubtitles = [String]()
        
        for offset in 0..<7 {
            // Determine the day components.
            components.day = offset
            let dayDate = (calendar as NSCalendar).date(byAdding: components, to: startDate, options: [])!
            let dayComponents = NSDateComponents(date: dayDate, calendar: calendar)
            
            // Store the knee pain result for the current day.
            if let result = kneePainEvents[dayComponents as DateComponents].first?.result, let score = Int(result.valueString), score > 0 {
                kneePainValues.append(score)
                kneePainLabels.append(result.valueString)
            }
            else {
                kneePainValues.append(0)
                kneePainLabels.append(NSLocalizedString("N/A", comment: ""))
            }
            
            // Store the mood result for the current day.
            if let result = moodEvents[dayComponents as DateComponents].first?.result, let score = Int(result.valueString), score > 0 {
                moodValues.append(score)
                moodLabels.append(result.valueString)
            }
            else {
                moodValues.append(0)
                moodLabels.append(NSLocalizedString("N/A", comment: ""))
            }
            
            // Store the incision pain result for the current day.
            if let result = incisionPainEvents[dayComponents as DateComponents].first?.result, let score = Int(result.valueString), score > 0 {
                incisionPainValues.append(score)
                incisionPainLabels.append(result.valueString)
            }
            else {
                incisionPainValues.append(0)
                incisionPainLabels.append(NSLocalizedString("N/A", comment: ""))
            }
            
            // Set the axis labels
            axisTitles.append(dayOfWeekFormatter.string(from: dayDate))
            axisSubtitles.append(shortDateFormatter.string(from: dayDate))
        }
        
        // Create a 'OCKBarSeries' for each set of data.
        let kneePainBarSeries = OCKBarSeries(title: "Knee Pain", values: kneePainValues as [NSNumber], valueLabels: kneePainLabels, tintColor: Colors.turquoiseLight1.color)
        let incisionPainBarSeries = OCKBarSeries(title: "Incision Pain", values: incisionPainValues as [NSNumber], valueLabels: incisionPainLabels, tintColor: Colors.turquoiseLight2.color)
        let moodBarSeries = OCKBarSeries(title: "Mood", values: moodValues as [NSNumber], valueLabels: moodLabels, tintColor: Colors.turquoiseLight3.color)
        
        // Add the series to a chart
        let chart = OCKBarChart(title: "Pain and Mood", text: nil, tintColor: Colors.turquoise.color, axisTitles: axisTitles, axisSubtitles: axisSubtitles, dataSeries: [kneePainBarSeries, incisionPainBarSeries, moodBarSeries], minimumScaleRangeValue: 0, maximumScaleRangeValue: 10)
        
        
        // Create a custom line graph to display instead
        let lineGraph = LineGraphChart.init()
        return lineGraph
        
        // Return the final chart.
        //return chart
    }
}
