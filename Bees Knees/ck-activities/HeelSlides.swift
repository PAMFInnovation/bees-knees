//
//  HeelSlides.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/30/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import CareKit


struct HeelSlides: Activity {
    let activityType: ActivityType = .HeelSlides
    
    let rationale: String = NSLocalizedString("\u{2022} Increases knee’s range of motion\n\u{2022} Promotes circulation\n\u{2022} Builds strength in surgical knee and leg\n\u{2022} Assists with getting out of bed", comment: "")
    let image: (name: String, type: String) = ("ref_heelslides", "png")
    let video: (name: String, type: String) = ("HeelSlide", "mp4")
    
    func carePlanActivity() -> OCKCarePlanActivity {
        // Create the weekly schedule
        let startDate = DateComponents(year: 2016, month: 11, day: 01)
        let schedule = OCKCareSchedule.weeklySchedule(withStartDate: startDate as DateComponents, occurrencesOnEachDay: [3, 3, 3, 3, 3, 3, 3])
        
        // Set localized strings to be used in the activity
        let title = NSLocalizedString("Heel Slides", comment: "")
        let summary = NSLocalizedString("10-20 reps", comment: "")
        let instructions = NSLocalizedString("\u{2022} Do slowly\n\u{2022} Keep kneecaps pointed towards ceiling throughout exercise.\n\u{2022} Slide one foot towards your buttocks, bending your hip and knee.\n\u{2022} Slowly return to starting position.\n\u{2022} Repeat 10 times, gradually building to 20 reps.", comment: "")
        
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
