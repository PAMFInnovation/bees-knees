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
                "- Bring your coach, if possible\n" +
                "- Spend 3 hours for medical testing\n" +
                "- Bring a list of questions\n" +
                "- Sign documentation"
            
        case .Orthopedic:
            return "" +
                "Plan to:\n" +
                "- Bring your coach, if possible\n" +
                "- Have a brief consultation with your surgeon to confirm details of the surgery\n" +
                "- Bring a list of questions\n" +
                "- Bring your medication list"
            
        case .Surgery:
            return "" +
                "Plan to:\n" +
                "- Arrive at the hospital at least 2 hours before hand\n" +
                "- Bring your coach, if possible\n" +
                "- Bring your packed bag\n" +
                "- Answer many questions as part of surgery safety"
            
        case .FollowUp2Week:
            return "" +
                "Plan to:\n" +
                "- Bring your coach, if possible\n" +
                "- Spend 3 hours for medical testing\n" +
                "- Bring a list of questions\n" +
                "- Sign documentation"
            
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
