//
//  ChairPressUps.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/30/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import CareKit


struct ChairPressUps: Activity {
    let activityType: ActivityType = .ChairPressUps
    
    let rationale: String = NSLocalizedString("\u{2022} Practices sitting to standing to sitting again safely\n\u{2022} Practices using legs and arms together", comment: "")
    let image: (name: String, type: String) = ("ref_chairpressups", "png")
    let video: (name: String, type: String) = ("", "")
    
    func carePlanActivity() -> OCKCarePlanActivity {
        // Create the weekly schedule
        let startDate = DateComponents(year: 2016, month: 11, day: 01)
        let schedule = OCKCareSchedule.weeklySchedule(withStartDate: startDate as DateComponents, occurrencesOnEachDay: [3, 3, 3, 3, 3, 3, 3])
        
        // Set localized strings to be used in the activity
        let title = NSLocalizedString("Chair Press Ups", comment: "")
        let summary = NSLocalizedString("10-20 reps", comment: "")
        let instructions = NSLocalizedString("\u{2022} Do slowly\n\u{2022} Sitting in a chair with armrest, place both hands on the armrests.\n\u{2022} Push down with your hands and lift your body straight up in the chair.\n\u{2022} Hold for 5 seconds then slowly lower your body down.\n\u{2022} Repeat 10 times, gradually building to 20 reps.", comment: "")
        
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
