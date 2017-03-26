//
//  Activity.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 8/19/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import CareKit


struct ActivityContainer {
    let activity: Activity
    let carePlanActivity: OCKCarePlanActivity
}

protocol Activity {
    var activityType: ActivityType { get }
    
    var rationale: String { get }
    var image: (name: String, type: String) { get }
    var video: (name: String, type: String) { get }
    
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
    case Recovery
}

class ActivityFactory {
    
    static func activityWithType(_ type: ActivityType) -> Activity? {
        switch type {
        case .Walk: return Walk()
        case .QuadSets: return QuadSets()
        case .AnklePumps: return AnklePumps()
        case .GluteSets: return GluteSets()
        case .HeelSlides: return HeelSlides()
        case .StraightLegRaises: return StraightLegRaises()
        case .SeatedHeelSlides: return SeatedHeelSlides()
        case .HamstringSets: return HamstringSets()
        case .ChairPressUps: return ChairPressUps()
        case .AbdominalBracing: return AbdominalBracing()
        default: return nil
        }
    }
}
