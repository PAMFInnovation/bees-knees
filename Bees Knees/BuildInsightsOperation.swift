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

class BuildInsightsOperation: Operation {
    
    // MARK: - Properties
    
    var legPainEvents: DailyEvents?
    
    fileprivate(set) var insights = [OCKInsightItem.emptyInsightsMessage()]
    
    // MARK: - Operation
    
    override func main() {
        // Do nothing if the operation has been cancelled.
        guard !isCancelled else { return }
        
        // Create an array of insights.
        var newInsights = [OCKInsightItem]()
        
        //if let insight = create
    }
    
    // MARK: - Convenience
    
    func createLegPainInsight() -> OCKInsightItem? {
        // Make sure there are events to parse.
        guard let legPainEvents = legPainEvents else { return nil }
        
        // Determine the start date for the previous week.
        let calendar = Calendar.current
        let now = Date()
        
        var components = DateComponents()
        components.day = -7
        let startDate = calendar.weekDatesForDate((calendar as NSCalendar).date(byAdding: components, to: now, options: [])!).start
        
        var totalEventCount = 0
        var completedEventCount = 0
        
        for offset in 0..<7 {
            components.day = offset
            let dayDate = (calendar as NSCalendar).date(byAdding: components, to: startDate, options: [])!
            let dayComponents = NSDateComponents(date: dayDate, calendar: calendar)
            let eventsForDay = legPainEvents[dayComponents as DateComponents]
            
            totalEventCount += eventsForDay.count
            
            for event in eventsForDay {
                if event.state == .completed {
                    completedEventCount += 1
                }
            }
        }
        
        guard totalEventCount > 0 else { return nil }
        
        // Calculate the percentage of completed events.
        let legPainAdherence = Float(completedEventCount) / Float(totalEventCount)
        
        // Create an 'OCKMessageItem' describing adherence.
        let percentageFormatter = NumberFormatter()
        percentageFormatter.numberStyle = .percent
        let formattedAdherence = percentageFormatter.string(from: NSNumber(value: legPainAdherence))!
        
        let insight = OCKMessageItem(title: "Leg Pain Adherence", text: "Your leg pain adherence was \(formattedAdherence) last week.", tintColor: UIColor.purple, messageType: .tip)
        
        return insight
    }
}
