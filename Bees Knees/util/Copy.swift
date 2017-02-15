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
                "- Bring your coach, if possible\n" +
                "- Spend 3 hours for medical testing and class\n" +
                "- Bring your list of questions, if any\n" +
                "- Bring filled out questionnaires for: Plans for Discharge, Anesthesia, Sleep Apnea"
            
        case .Orthopedic:
            return "" +
                "Plan to:\n" +
                "- Bring your coach, if possible\n" +
                "- Confirm surgery details with your surgeon\n" +
                "- Bring your binder and list of questions, if any\n" +
                "- Bring your medication list"
            
        case .Surgery:
            return "" +
                "Plan to:\n" +
                "- Start HibiClens shower routine 2-3 days before\n" +
                "- Drink only water the day before and of surgery\n" +
                "- Arrive at the hospital at least 2 hours beforehand\n" +
                "- Bring your coach, if possible\n" +
                "- Bring your packed bag\n" +
                "- Be asked many questions for surgery safety\n" +
                "- Use your spirometer before and after surgery"
            
        case .FollowUp2Week:
            return "" +
                "Plan to:\n" +
                "- Check you range of motion and strength\n" +
                "- Bring your list of questions, if any\n" +
                "- Share any difficulties in increasing activity levels"
            
        case .FollowUp6Week:
            return "" +
                "Plan to:\n" +
                "- Bring your coach, if possible\n" +
                "- Spend 3 hours for medical testing\n" +
                "- Bring a list of questions\n" +
                "- Sign documentation"
            
        case .FollowUp12Week:
            return "" +
                "Plan to:\n" +
                "- Bring your coach, if possible\n" +
                "- Spend 3 hours for medical testing\n" +
                "- Bring a list of questions\n" +
                "- Sign documentation"
            
        default:
            return ""
        }
    }
}
