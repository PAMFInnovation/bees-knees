//
//  ProfileManager.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 10/26/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import Foundation
import RealmSwift


final class User: Object {
    
    // Primary key
    dynamic var id = 0
    
    // Current state of the App
    dynamic var flowState: FlowState = .Launch
    
    // Personal data
    dynamic var name: String = ""
    dynamic var email: String = ""
    dynamic var phone: String = ""
    dynamic var goal: String = ""
    
    // Notes
    var notes: String = ""
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
}


class ProfileManager {
    // Singleton
    static let sharedInstance = ProfileManager()
    private init() {
        // Get the default realm
        realm = try! Realm()
        
        // Get the user object from realm. If it doesn't exist, create a new user.
        guard let userObject = realm.object(ofType: User.self, forPrimaryKey: 0) else {
            createNewUser()
            
            // Exit
            return
        }
        
        // Set the user
        user = userObject
        print("user", user.description)
    }
    
    // Realm object
    let realm: Realm
    
    // User object
    var user: User = User()
    
    
    // Date of surgery
    var surgeryAppointment: Appointment = Appointment(title: "Surgery", type: AppointmentType.Surgery)
    var isSurgerySet: Bool = false
    
    // Appointments
    var appointments: [Appointment] = [Appointment]()
    
    // Consent document
    var consent = ConsentDocument.copy()
    
    
    func getSurgeryDate() -> Date {
        return surgeryAppointment.date
    }
    
    func setSurgeryDate(_ date: Date) {
        surgeryAppointment.date = date
        surgeryAppointment.scheduled = true
        isSurgerySet = true
    }
    
    func getFlowState() -> FlowState {
        return user.flowState
    }
    
    func checkFlowState(_ flowState: FlowState) -> Bool {
        if user.flowState == flowState {
            return true
        }
        return false
    }
    
    func updateFlowState(_ flowState: FlowState) {
        try! realm.write {
            user.flowState = flowState
        }
    }
    
    func updateUserInfo(name: String?, email: String?, phone: String?) {
        realm.beginWrite()
        
        if let _name = name {
            user.name = _name
        }
        if let _email = email {
            user.email = _email
        }
        if let _phone = phone {
            user.phone = _phone
        }
        
        try! realm.commitWrite()
    }
    
    func updateUserGoal(goal: String) {
        try! realm.write {
            user.goal = goal
        }
    }
    
    func getUserNotes() -> String {
        return user.notes
    }
    
    func updateUserNotes(notes: String) {
        try! realm.write {
            user.notes = notes
        }
    }
    
    func createNewUser() {
        user = User()
        
        // Save the user object
        try! realm.write {
            realm.add(user)
        }
    }
    
    func resetData() {
        try! realm.write {
            realm.deleteAll()
        }
        
        self.createNewUser()
    }
}
