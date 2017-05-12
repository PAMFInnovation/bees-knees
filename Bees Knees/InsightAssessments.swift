//
//  InsightAssessments.swift
//  Bees Knees
//
//  Created by Kranthi Vallamreddy on 5/10/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import Foundation

class InsightAssessments {
    
    public var events: DailyEvents
    
    public var assessment: String = ""
    
    init(events:DailyEvents, assessment:String) {
        self.events = events
        self.assessment = assessment
    }
}
