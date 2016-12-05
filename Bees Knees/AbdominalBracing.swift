//
//  AbdominalBracing.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/30/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import CareKit


struct AbdominalBracing: Activity {
    let activityType: ActivityType = .AbdominalBracing
    
    func carePlanActivity() -> OCKCarePlanActivity {
        // Create the weekly schedule
        let startDate = NSDateComponents(year: 2016, month: 8, day: 11)
        let schedule = OCKCareSchedule.weeklySchedule(withStartDate: startDate as DateComponents, occurrencesOnEachDay: [1, 1, 1, 1, 1, 1, 1])
        
        // Set localized strings to be used in the activity
        let title = NSLocalizedString("Abdominal Bracing", comment: "")
        let summary = NSLocalizedString("10-20 reps", comment: "")
        let instructions = NSLocalizedString("\u{2022} Do slowly\n\u{2022} Lie on your back.\n\u{2022} Bend your knees up.\n\u{2022} Tighten your abdominal muscles by bringing your belly button in.\n\u{2022} Hold for 5 seconds and then relax\n\u{2022} Repeat 10 times, gradually building to 20 reps.", comment: "")
        
        // Create the intervention activity
        let activity = OCKCarePlanActivity.intervention(
            withIdentifier: activityType.rawValue,
            groupIdentifier: nil,
            title: title,
            text: summary,
            tintColor: Colors.turquoise.color,
            instructions: instructions,
            imageURL: Util.getURLForResource(resource: "ref_abdominalbracing", type: "png") as URL,
            schedule: schedule,
            userInfo: nil
        )
        
        return activity
    }
}