//
//  DynamicActivity.swift
//  Bees Knees
//
//  Created by Kranthi Vallamreddy on 4/26/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import Foundation

import CareKit


struct DynamicActivity: Activity {
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
        // Create the weekly schedule
        let startDate = DateComponents(year: 2016, month: 11, day: 01)
        let bubble = Int(self.bubbles)! as NSNumber
        let schedule = OCKCareSchedule.weeklySchedule(withStartDate: startDate as DateComponents, occurrencesOnEachDay: [bubble, bubble, bubble, bubble, bubble, bubble, bubble])
        
        // Set localized strings to be used in the activity
        let title = NSLocalizedString(self.title, comment: "")
        let summary = NSLocalizedString(self.repetitionsText, comment: "")
        let instructions = NSLocalizedString(self.instructions, comment: "")
        
        // Create the intervention activity
        let activity = OCKCarePlanActivity.intervention(
            withIdentifier: activityType.rawValue,
            groupIdentifier: nil,
            title: title,
            text: summary,
            tintColor: Colors.turquoise.color,
            instructions: instructions,
            imageURL: Util.getURLForResource(resource: image, type: "png") as URL,
            schedule: schedule,
            userInfo: nil
        )
        
        return activity
    }
}
