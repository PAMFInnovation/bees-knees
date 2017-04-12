//
//  StraightLegRaisesMills.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/30/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import CareKit


struct StraightLegRaisesMills: Activity {
    let activityType: ActivityType = .StraightLegRaisesMills
    
    let rationale: String = NSLocalizedString("", comment: "")
    let image: (name: String, type: String) = ("ref_straightlegraises_mills", "png")
    let video: (name: String, type: String) = ("StraighLegRaises", "mp4")
    
    func carePlanActivity() -> OCKCarePlanActivity {
        // Create the weekly schedule
        let startDate = DateComponents(year: 2016, month: 11, day: 01)
        let schedule = OCKCareSchedule.weeklySchedule(withStartDate: startDate as DateComponents, occurrencesOnEachDay: [2, 2, 2, 2, 2, 2, 2])
        
        // Set localized strings to be used in the activity
        let title = NSLocalizedString("Straight Leg Raises", comment: "")
        let summary = NSLocalizedString("3 sets of 10 reps", comment: "")
        let instructions = NSLocalizedString("Bend non-operative leg. Keep other leg as straight as possible and tighten muscles on top of thigh. Slowly lift straight leg 6-8 inches from bed and hold for 10 seconds. Relax. Repeat.", comment: "")
        
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
