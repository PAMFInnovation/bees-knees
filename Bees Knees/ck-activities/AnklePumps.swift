//
//  AnklePumps.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/30/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import CareKit


struct AnklePumps: Activity {
    let activityType: ActivityType = .AnklePumps
    
    let rationale: String = NSLocalizedString("\u{2022} Decreases risk of blood clots\n\u{2022} Promotes circulation to lower leg and foot\n\u{2022} Helps with ankle range of motion\n\u{2022} Decreases swelling in knee, if done with other exercises", comment: "")
    let image: (name: String, type: String) = ("ref_anklepumps", "png")
    let video: (name: String, type: String) = ("AnklePumps", "mp4")
    
    func carePlanActivity() -> OCKCarePlanActivity {
        // Create the weekly schedule
        let startDate = DateComponents(year: 2016, month: 11, day: 01)
        let schedule = OCKCareSchedule.weeklySchedule(withStartDate: startDate as DateComponents, occurrencesOnEachDay: [3, 3, 3, 3, 3, 3, 3])
        
        // Set localized strings to be used in the activity
        let title = NSLocalizedString("Ankle Pumps", comment: "")
        let summary = NSLocalizedString("10-20 reps", comment: "")
        let instructions = NSLocalizedString("\u{2022} Do slowly\n\u{2022} Point toes towards foot of bed.\n\u{2022} Pull toes towards your head.\n\u{2022} Repeat 10 times, gradually building to 20 reps.", comment: "")
        
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
