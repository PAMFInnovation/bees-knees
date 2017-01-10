//
//  ProfileManager.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 10/26/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import Foundation


class ProfileManager {
    // Singleton
    static let sharedInstance = ProfileManager()
    private init() {}
    
    // Set the initial app's flow state
    var flowState: FlowState = .Launch
    
    // Personal data
    var name: String = ""
    var email: String = ""
    var phone: String = ""
    
    // Goal
    var goal: String = ""
    
    // Date of surgery
    var surgeryAppointment: Appointment = Appointment(title: "Surgery", type: AppointmentType.Surgery)
    var isSurgerySet: Bool = false
    
    // Notes
    var notes: String = ""
    
    // Appointments
    var appointments: [Appointment] = [Appointment]()
    
    // Consent document
    var consent = ConsentDocument.copy()
    
    
    func getSurgeryDate() -> Date {
        return surgeryAppointment.date!
    }
    
    func setSurgeryDate(_ date: Date) {
        surgeryAppointment.date = date
        surgeryAppointment.scheduled = true
        isSurgerySet = true
    }
}
