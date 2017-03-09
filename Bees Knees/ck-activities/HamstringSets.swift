//
//  HamstringSets.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/30/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import CareKit


struct HamstringSets: Activity {
    let activityType: ActivityType = .HamstringSets
    
    let rationale: String = NSLocalizedString("\u{2022} Promotes circulation in hamstring muscles\n\u{2022} Activates hamstring muscles, which help control your knee joint in standing and walking", comment: "")
    let image: (name: String, type: String) = ("ref_hamstringsets", "png")
    let video: (name: String, type: String) = ("HamstringSets", "mp4")
    
    func carePlanActivity() -> OCKCarePlanActivity {
        // Create the weekly schedule
        let startDate = DateComponents(year: 2016, month: 11, day: 01)
        let schedule = OCKCareSchedule.weeklySchedule(withStartDate: startDate as DateComponents, occurrencesOnEachDay: [3, 3, 3, 3, 3, 3, 3])
        
        // Set localized strings to be used in the activity
        let title = NSLocalizedString("Hamstring Sets", comment: "")
        let summary = NSLocalizedString("10-20 reps", comment: "")
        let instructions = NSLocalizedString("\u{2022} Do slowly\n\u{2022} Keeping one leg straight, bend the other to the height of about 6 inches. Tighten the bent leg by digging down and back with the heel.\n\u{2022} Hold for 5 seconds and then relax.\n\u{2022} Repeat 10 times, gradually building to 20 reps.", comment: "")
        
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
