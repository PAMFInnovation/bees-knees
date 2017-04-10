//
//  KneeSlidesMills.swift
//  Bees Knees
//
//  Created by Kranthi Vallamreddy on 4/10/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import CareKit


struct KneeSlidesMills: Activity {
    let activityType: ActivityType = .KneeSlidesMills
    
    let rationale: String = NSLocalizedString("\u{2022} Activate hip muscles which are important for walking\n\u{2022} Practices using hip muscles and knee together", comment: "")
    let image: (name: String, type: String) = ("ref_straightlegraises", "png")
    let video: (name: String, type: String) = ("", "")
    
    func carePlanActivity() -> OCKCarePlanActivity {
        // Create the weekly schedule
        let startDate = DateComponents(year: 2016, month: 11, day: 01)
        let schedule = OCKCareSchedule.weeklySchedule(withStartDate: startDate as DateComponents, occurrencesOnEachDay: [3, 3, 3, 3, 3, 3, 3])
        
        // Set localized strings to be used in the activity
        let title = NSLocalizedString("Knee Slides", comment: "")
        let summary = NSLocalizedString("10 reps", comment: "")
        let instructions = NSLocalizedString("Slowly slide your foot back as far as you can and hold 10 seconds. Relax. Repeat.", comment: "")
        
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

