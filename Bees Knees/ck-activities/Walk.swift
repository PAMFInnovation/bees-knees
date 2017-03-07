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
    
    let rationale: String = NSLocalizedString("", comment: "")
    let image: (name: String, type: String) = ("", "")
    let video: (name: String, type: String) = ("", "")
    
    func carePlanActivity() -> OCKCarePlanActivity {
        // Create the weekly schedule
        let startDate = DateComponents(year: 2016, month: 11, day: 01)
        let schedule = OCKCareSchedule.weeklySchedule(withStartDate: startDate as DateComponents, occurrencesOnEachDay: [1, 1, 1, 1, 1, 1, 1])
        
        // Set localized strings to be used in the activity
        let title = NSLocalizedString("Walk", comment: "")
        let summary = NSLocalizedString("20-30 minutes", comment: "")
        let instructions = NSLocalizedString("More than strengthening muscle, walking strengthens the heart and circulatory system, making them more able to cope with the stresses that will be put on them from surgery. Before starting a walking program, please consult with your doctor or therapist. Always use any assistive device already prescribed to you and make sure you walk in a safe environment. Gradually increase the time that you walk so that you can walk up to 30 minutes at a time.", comment: "")
        
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
