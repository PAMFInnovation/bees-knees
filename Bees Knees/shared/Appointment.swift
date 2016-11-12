//
//  Appointment.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/10/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import Foundation


enum AppointmentType {
    case CheckUp
    case Consultation
    case PreOp
    case Orthopedic
    case FollowUp2Week
    case FollowUp6Week
    case FollowUp12Week
    case Surgery
    
    var description: String {
        switch self {
        case .CheckUp: return "Check up"
        case .Consultation: return "Consultation"
        case .PreOp: return "Pre-operative appointment"
        case .Orthopedic: return "Orthopedic surgeon appointment"
        case .FollowUp2Week: return "2-week follow up"
        case .FollowUp6Week: return "6-week follow up"
        case .FollowUp12Week: return "12-week follow up"
        case .Surgery: return "Surgery"
        }
    }
}


class Appointment: NSObject {
    
    var title: String!
    var type: AppointmentType!
    var date: Date?
    var place: String!
    var notes: String!
    var elapsed: Bool!
    
    override init() {
        title = ""
        type = AppointmentType.CheckUp
        place = ""
        notes = ""
        elapsed = false
    }
    
    init(title: String, type: AppointmentType) {
        self.title = title
        self.type = type
        self.place = ""
        self.notes = ""
        self.elapsed = false
    }
    
    init(title: String, type: AppointmentType, date: Date) {
        self.title = title
        self.type = type
        self.date = date
        self.place = ""
        self.notes = ""
        self.elapsed = Util.isDateInPast(date)
    }
    
    init(title: String, type: AppointmentType, date: Date, place: String, notes: String) {
        self.title = title
        self.type = type
        self.date = date
        self.place = place
        self.notes = notes
        self.elapsed = Util.isDateInPast(date)
    }
    
    override var description: String {
        return "\(title) - \(type.description) - \(date) - \(place) - \(notes)"
    }
}
