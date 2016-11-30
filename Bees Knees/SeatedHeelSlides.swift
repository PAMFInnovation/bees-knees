//
//  SeatedHeelSlides.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/30/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import CareKit


struct SeatedHeelSlides: Activity {
    let activityType: ActivityType = .SeatedHeelSlides
    
    func carePlanActivity() -> OCKCarePlanActivity {
        // Create the weekly schedule
        let startDate = NSDateComponents(year: 2016, month: 8, day: 11)
        let schedule = OCKCareSchedule.weeklySchedule(withStartDate: startDate as DateComponents, occurrencesOnEachDay: [3, 3, 3, 3, 3, 3, 3])
        
        // Set localized strings to be used in the activity
        let title = NSLocalizedString("Straight Heel Slides", comment: "")
        let summary = NSLocalizedString("10-20 reps", comment: "")
        let instructions = NSLocalizedString("\u{2022} Do slowly\n\u{2022} Sit on the edge of your bed or in a chair so that the foot of your operated leg is flat on the floor with a \"slipper\" material such as a washcloth underneath it.\n\u{2022} Slide your foot back, then forward.\n\u{2022} You may cross your ankles so your strong leg helps your operated knee to bend.\n\u{2022} Repeat 10 times, gradually building to 20 reps.", comment: "")
        
        // Create the intervention activity
        let activity = OCKCarePlanActivity.intervention(
            withIdentifier: activityType.rawValue,
            groupIdentifier: nil,
            title: title,
            text: summary,
            tintColor: Colors.turquoise.color,
            instructions: instructions,
            imageURL: Util.getURLForResource(resource: "ref_seatedheelslides", type: "png") as URL,
            schedule: schedule,
            userInfo: nil
        )
        
        return activity
    }
}
