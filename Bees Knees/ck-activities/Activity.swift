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
    
    var title: String { get }
    var instructions: String { get }
    var repetitionsText: String { get }
    var bubbles: String { get }
    var rationale: String { get }
    var image: String { get }
    var video: String { get }
    
    init(activityType: ActivityType, title: String, instructions: String, repetitionsText: String, bubbles: String, rationale: String, image: String, video: String)
    
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
    case AnklePumpsMills
    case QuadSetsMills
    case HeelSlidesMills
    case LongArcQuadsMills
    case KneeSlidesMills
    case ShortArcQuadsMills
    case StraightLegRaisesMills
}

//class ActivityFactory {
//    
//    static func activityWithType(_ type: ActivityType) -> Activity? {
//        switch type {
//        case .Walk: return DynamicActivity(activityType: ActivityType.Walk, title: "Walk Title", instructions: "Walk Instructions", repetitionsText: "rep text", bubbles: "2", rationale: "rationale", image: "", video: "")
//        case .QuadSets: return DynamicActivity(activityType: ActivityType.QuadSets, title: "Walk Title", instructions: "Walk Instructions", repetitionsText: "rep text", bubbles: "2", rationale: "rationale", image: "", video: "")
//        case .AnklePumps: return DynamicActivity(activityType: ActivityType.AnklePumps, title: "Walk Title", instructions: "Walk Instructions", repetitionsText: "rep text", bubbles: "2", rationale: "rationale", image: "", video: "")
//        case .GluteSets: return DynamicActivity(activityType: ActivityType.GluteSets, title: "Walk Title", instructions: "Walk Instructions", repetitionsText: "rep text", bubbles: "2", rationale: "rationale", image: "", video: "")
//        case .HeelSlides: return DynamicActivity(activityType: ActivityType.HeelSlides, title: "Walk Title", instructions: "Walk Instructions", repetitionsText: "rep text", bubbles: "2", rationale: "rationale", image: "", video: "")
//        case .StraightLegRaises: return DynamicActivity(activityType: ActivityType.StraightLegRaises, title: "Walk Title", instructions: "Walk Instructions", repetitionsText: "rep text", bubbles: "2", rationale: "rationale", image: "", video: "")
//        case .HamstringSets: return DynamicActivity(activityType: ActivityType.HamstringSets, title: "Walk Title", instructions: "Walk Instructions", repetitionsText: "rep text", bubbles: "2", rationale: "rationale", image: "", video: "")
//        case .ChairPressUps: return DynamicActivity(activityType: ActivityType.ChairPressUps, title: "Walk Title", instructions: "Walk Instructions", repetitionsText: "rep text", bubbles: "2", rationale: "rationale", image: "", video: "")
//        case .AbdominalBracing: return DynamicActivity(activityType: ActivityType.AbdominalBracing, title: "Walk Title", instructions: "Walk Instructions", repetitionsText: "rep text", bubbles: "2", rationale: "rationale", image: "", video: "")
//        default: return nil
//        }
//    }
//}
