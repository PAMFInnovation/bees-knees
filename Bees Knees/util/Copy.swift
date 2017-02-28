//
//  Copy.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/11/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import Foundation


class Copy {
    static func getWildernessGuideCopy(type: AppointmentType) -> String {
        switch type {
        case .PreOp:
            return "" +
                "Plan to:\n" +
                "- Bring your binder and medication list\n" +
                "- Bring your coach\n" +
                "- Spend 2-3 hours for medical testing and class\n" +
                "- Bring your list of questions, if any\n" +
                "- Bring filled out questionnaires for: Plans for Discharge, Anesthesia, Sleep Apnea"
            
        case .Orthopedic:
            return "" +
                "Plan to:\n" +
                "- Bring your coach\n" +
                "- Confirm surgery details with your surgeon\n" +
                "- Bring your binder and list of questions, if any\n" +
                "- Bring your medication list"
            
        case .Surgery:
            return "" +
                "Plan to:\n" +
                "- Start HibiClens shower routine 2-3 days before\n" +
                "- Follow fasting instructions provided by your surgeon or anesthesiologist\n" +
                "- Arrive at the hospital at least 2 hours beforehand\n" +
                "- Bring your coach\n" +
                "- Bring your binder and packed bag\n" +
                "- Be asked many questions for surgery safety\n" +
                "- Use your spirometer before and after surgery"
            
        case .FollowUp2Week:
            return "" +
                "Plan to:\n" +
                "- Check your range of motion and strength\n" +
                "- Bring your list of questions, if any\n" +
                "- Share any difficulties in increasing activity levels"
            
        case .FollowUp6Week:
            return "" +
                "Plan to:\n" +
                "- Check your range of motion and strength\n" +
                "- Bring your list of questions, if any\n" +
                "- Share any difficulties in increasing activity levels"
            
        case .FollowUp12Week:
            return "" +
                "Plan to:\n" +
                "- Check your range of motion and strength\n" +
                "- Bring your list of questions, if any\n" +
                "- Share any difficulties in increasing activity levels"
            
        default:
            return ""
        }
    }
}
