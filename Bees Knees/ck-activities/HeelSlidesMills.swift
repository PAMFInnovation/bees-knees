//
//  HeelSlides.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/30/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import CareKit


struct HeelSlidesMills: Activity {
    let activityType: ActivityType = .HeelSlidesMills
    
    let rationale: String = NSLocalizedString("\u{2022} Increases knee’s range of motion\n\u{2022} Promotes circulation\n\u{2022} Builds strength in surgical knee and leg\n\u{2022} Assists with getting out of bed", comment: "")
    let image: (name: String, type: String) = ("ref_heelslides", "png")
    let video: (name: String, type: String) = ("", "")
    
    func carePlanActivity() -> OCKCarePlanActivity {
        // Create the weekly schedule
        let startDate = DateComponents(year: 2016, month: 11, day: 01)
        let schedule = OCKCareSchedule.weeklySchedule(withStartDate: startDate as DateComponents, occurrencesOnEachDay: [3, 3, 3, 3, 3, 3, 3])
        
        // Set localized strings to be used in the activity
        let title = NSLocalizedString("Heel Slides", comment: "")
        let summary = NSLocalizedString("10 reps", comment: "")
        let instructions = NSLocalizedString("Bend knee and pull heel toward buttocks. Hold for 10 seconds. Relax. Repeat.", comment: "")
        
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
