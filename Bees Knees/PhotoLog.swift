//
//  PhotoLog.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/30/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import CareKit


struct PhotoLog: Activity {
    let activityType: ActivityType = .PhotoLog
    
    func carePlanActivity() -> OCKCarePlanActivity {
        // Create the weekly schedule
        let startDate = DateComponents(year: 2016, month: 11, day: 01)
        let schedule = OCKCareSchedule.weeklySchedule(withStartDate: startDate as DateComponents, occurrencesOnEachDay: [1, 0, 0, 0, 0, 0, 0])
        
        // Set localized strings to be used in the activity
        let title = NSLocalizedString("Photo Journal Log", comment: "")
        let summary = NSLocalizedString("", comment: "")
        let instructions = NSLocalizedString("Take a photo of the incision site every week, and then you can see the progress every week in th Progress Tracker.", comment: "")
        
        // Create the intervention activity
        let activity = OCKCarePlanActivity.intervention(
            withIdentifier: activityType.rawValue,
            groupIdentifier: nil,
            title: title,
            text: summary,
            tintColor: Colors.turquoise.color,
            instructions: instructions,
            imageURL: nil,
            schedule: schedule,
            userInfo: nil
        )
        
        return activity
    }
}
