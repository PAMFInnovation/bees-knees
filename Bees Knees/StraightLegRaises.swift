//
//  StraightLegRaises.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/30/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import CareKit


struct StraightLegRaises: Activity {
    let activityType: ActivityType = .StraightLegRaises
    
    func carePlanActivity() -> OCKCarePlanActivity {
        // Create the weekly schedule
        let startDate = NSDateComponents(year: 2016, month: 8, day: 11)
        let schedule = OCKCareSchedule.weeklySchedule(withStartDate: startDate as DateComponents, occurrencesOnEachDay: [3, 3, 3, 3, 3, 3, 3])
        
        // Set localized strings to be used in the activity
        let title = NSLocalizedString("Straight Leg Raises", comment: "")
        let summary = NSLocalizedString("10-20 reps", comment: "")
        let instructions = NSLocalizedString("\u{2022} Do slowly\n\u{2022} Keep kneecap pointed towards ceiling throughout exercise.\n\u{2022} Bend opposite knee so the foot is flat on the bed (this takes the stress off your low back area).\n\u{2022} Tighten muscles in your thigh and raise the leg off the bed. Keep the knee as straight as you can as you raise and then lower the leg back to the bed.\n\u{2022} Be sure to use your knee immobilizer during this exercise until you are able to raise and lower the leg by yourself. Once you achieve this, remove the immobilizer and continue to work on lifting and lowering the leg without help.\n\u{2022} Repeat 10 times, gradually building to 20 reps.", comment: "")
        
        // Create the intervention activity
        let activity = OCKCarePlanActivity.intervention(
            withIdentifier: activityType.rawValue,
            groupIdentifier: nil,
            title: title,
            text: summary,
            tintColor: Colors.turquoise.color,
            instructions: instructions,
            imageURL: Util.getURLForResource(resource: "ref_straightlegraises", type: "png") as URL,
            schedule: schedule,
            userInfo: nil
        )
        
        return activity
    }
}
