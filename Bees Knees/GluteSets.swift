//
//  GluteSets.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/30/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import CareKit


struct GluteSets: Activity {
    let activityType: ActivityType = .GluteSets
    
    let rationale: String = NSLocalizedString("", comment: "")
    let image: (name: String, type: String) = ("ref_glutesets", "png")
    
    func carePlanActivity() -> OCKCarePlanActivity {
        // Create the weekly schedule
        let startDate = DateComponents(year: 2016, month: 11, day: 01)
        let schedule = OCKCareSchedule.weeklySchedule(withStartDate: startDate as DateComponents, occurrencesOnEachDay: [3, 3, 3, 3, 3, 3, 3])
        
        // Set localized strings to be used in the activity
        let title = NSLocalizedString("Glute Sets", comment: "")
        let summary = NSLocalizedString("10-20 reps", comment: "")
        let instructions = NSLocalizedString("\u{2022} Do slowly\n\u{2022} Squeeze your buttocks together as tightly as possible.\n\u{2022} Hold for 5 seconds and then relax.\n\u{2022} Repeat 10 times, gradually building to 20 reps.", comment: "")
        
        // Create the intervention activity
        let activity = OCKCarePlanActivity.intervention(
            withIdentifier: activityType.rawValue,
            groupIdentifier: nil,
            title: title,
            text: summary,
            tintColor: Colors.turquoise.color,
            instructions: instructions,
            imageURL: Util.getURLForResource(resource: image.name, type: image.type) as URL,
            schedule: schedule,
            userInfo: nil
        )
        
        return activity
    }
}
