//
//  Appointment.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/10/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import Foundation
import RealmSwift


@objc enum AppointmentType: Int {
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


final class Appointment: Object {
    
    dynamic var title: String = ""
    dynamic var type: AppointmentType = .CheckUp
    dynamic var date: Date = Date()
    dynamic var place: String = ""
    dynamic var notes: String = ""
    dynamic var elapsed: Bool = false
    dynamic var scheduled: Bool = false
    
    
    /*convenience init() {
        title = ""
        type = AppointmentType.CheckUp
        place = ""
        notes = ""
        elapsed = false
        scheduled = false
    }*/
    
    convenience init(title: String, type: AppointmentType) {
        self.init()
        
        self.title = title
        self.type = type
        self.date = Date()
        self.place = ""
        self.notes = ""
        self.elapsed = false
        self.scheduled = false
    }
    
    convenience init(title: String, type: AppointmentType, date: Date) {
        self.init()
        
        self.title = title
        self.type = type
        self.date = date
        self.place = ""
        self.notes = ""
        self.elapsed = Util.isDateInPast(date)
        self.scheduled = true
    }
    
    convenience init(title: String, type: AppointmentType, date: Date, place: String, notes: String) {
        self.init()
        
        self.title = title
        self.type = type
        self.date = date
        self.place = place
        self.notes = notes
        self.elapsed = Util.isDateInPast(date)
        self.scheduled = true
    }
    
    override var description: String {
        return "\(title) - \(type.description) - \(date) - \(place) - \(notes)"
    }
    
    func hasRequiredInfo() -> Bool {
        if title != "" && scheduled == true {
            return true
        }
        return false
    }
}
