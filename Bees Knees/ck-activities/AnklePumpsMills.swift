//
//  AnklePumpsMills.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/30/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import CareKit


struct AnklePumpsMills: Activity {
    let activityType: ActivityType = .AnklePumpsMills
    
    let rationale: String = NSLocalizedString("\u{2022} Decreases risk of blood clots\n\u{2022} Promotes circulation to lower leg and foot\n\u{2022} Helps with ankle range of motion\n\u{2022} Decreases swelling in knee, if done with other exercises", comment: "")
    let image: (name: String, type: String) = ("ref_anklepumps_mills", "png")
    let video: (name: String, type: String) = ("", "")
    
    func carePlanActivity() -> OCKCarePlanActivity {
        // Create the weekly schedule
        let startDate = DateComponents(year: 2016, month: 11, day: 01)
        let schedule = OCKCareSchedule.weeklySchedule(withStartDate: startDate as DateComponents, occurrencesOnEachDay: [3, 3, 3, 3, 3, 3, 3])
        
        // Set localized strings to be used in the activity
        let title = NSLocalizedString("Ankle Pumps", comment: "")
        let summary = NSLocalizedString("", comment: "")
        let instructions = NSLocalizedString("Bend ankles to move feet up and down, alternating feet. 10 times per hour", comment: "")
        
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
