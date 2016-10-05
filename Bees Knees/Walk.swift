//
//  Walk.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 8/19/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import CareKit


struct Walk: Activity {
    let activityType: ActivityType = .Walk
    
    func carePlanActivity() -> OCKCarePlanActivity {
        // Create the weekly schedule
        let startDate = NSDateComponents(year: 2016, month: 8, day: 11)
        let schedule = OCKCareSchedule.weeklySchedule(withStartDate: startDate as DateComponents, occurrencesOnEachDay: [2, 1, 1, 1, 1, 1, 2])
        
        // Set localized strings to be used in the activity
        let title = NSLocalizedString("Walk", comment: "")
        let summary = NSLocalizedString("15 mins", comment: "")
        let instructions = NSLocalizedString("Take a leisurely walk.", comment: "")
        
        // Create the intervention activity
        let activity = OCKCarePlanActivity.intervention(
            withIdentifier: activityType.rawValue,
            groupIdentifier: nil,
            title: title,
            text: summary,
            tintColor: UIColor.blue,
            instructions: instructions,
            imageURL: nil,
            schedule: schedule,
            userInfo: nil
        )
        
        return activity
    }
}
