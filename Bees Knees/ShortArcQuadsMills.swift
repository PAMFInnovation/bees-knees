//
//  ShortArcQuadsMills.swift
//  Bees Knees
//
//  Created by Kranthi Vallamreddy on 4/10/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import CareKit


struct ShortArcQuadsMills: Activity {
    let activityType: ActivityType = .ShortArcQuadsMills
    
    let rationale: String = NSLocalizedString("\u{2022} Promotes circulation in your thigh muscles\n\u{2022} Reminds your body how to activate your quad/thigh muscle\n\u{2022} Practices straightening surgical knee\n\u{2022} Decreases swelling in knee", comment: "")
    let image: (name: String, type: String) = ("ref_shortarcquads_mills", "png")
    let video: (name: String, type: String) = ("", "")
    
    func carePlanActivity() -> OCKCarePlanActivity {
        // Create the weekly schedule
        let startDate = DateComponents(year: 2016, month: 11, day: 01)
        let schedule = OCKCareSchedule.weeklySchedule(withStartDate: startDate as DateComponents, occurrencesOnEachDay: [2, 2, 2, 2, 2, 2, 2])
        
        // Set localized strings to be used in the activity
        let title = NSLocalizedString("Short Arc Quads", comment: "")
        let summary = NSLocalizedString("Work up to 3 sets of 10 reps", comment: "")
        let instructions = NSLocalizedString("Place a rolled towel under your knee. Raise the lower part of your leg until your knee is straight. Hold for 10 seconds. Relax. Repeat.", comment: "")
        
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


