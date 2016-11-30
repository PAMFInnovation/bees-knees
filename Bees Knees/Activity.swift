//
//  Activity.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 8/19/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import CareKit

protocol Activity {
    var activityType: ActivityType { get }
    
    func carePlanActivity() -> OCKCarePlanActivity
}

enum ActivityType: String {
    case Walk
    case QuadSets
    case AnklePumps
    case GluteSets
    case HeelSlides
    case StraightLegRaises
    case SeatedHeelSlides
    case HamstringSets
    case ChairPressUps
    case AbdominalBracing
    case PhotoLog
    case KneePain
    case Mood
    case IncisionPain
}
