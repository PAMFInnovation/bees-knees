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
    dynamic var notes: String = ""
    
    // Signed consent data
    dynamic var consentData: Data = Data()
    
    // Appointments
    let appointments = List<Appointment>()
    
    // Surgery appointment
    dynamic var surgeryAppointment: Appointment? = Appointment(title: "Surgery", type: AppointmentType.Surgery)
    dynamic var isSurgerySet: Bool = false
    
    // Checklist
    let checklist = List<ChecklistItem>()
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
}


class ProfileManager {
    
    // MARK: - Singleton
    static let sharedInstance = ProfileManager()
    private init() {
        // Delete the realm file
        //try! FileManager.default.removeItem(at: Realm.Configuration.defaultConfiguration.fileURL!)
        
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
    
    
    // MARK: - Members
    let realm: Realm        // Realm object
    var user: User = User() // User object
    
    
    // MARK: - Helper functions
    func isSurgerySet() -> Bool {
        return user.isSurgerySet
    }
    
    func getSurgeryAppointment() -> Appointment {
        return user.surgeryAppointment!
    }
    
    func getSurgeryDate() -> Date {
        return user.surgeryAppointment!.date
    }
    
    func setSurgeryDate(_ date: Date) {
        try! realm.write {
            user.surgeryAppointment!.date = date
            user.surgeryAppointment!.scheduled = true
            user.isSurgerySet = true
        }
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
    
    func getSignedConsentDocument() -> Data {
        return user.consentData
    }
    
    func updateSignedConsentDocument(data: Data) {
        try! realm.write {
            user.consentData = data
        }
    }
    
    func getAppointments() -> List<Appointment> {
        return user.appointments
    }
    
    func addAppointment(appt: Appointment) {
        try! realm.write {
            user.appointments.append(appt)
        }
    }
    
    func getChecklist() -> List<ChecklistItem> {
        return user.checklist
    }
    
    func addItemToChecklist(item: ChecklistItem) {
        try! realm.write {
            user.checklist.append(item)
        }
    }
    
    func removeItemFromChecklist(index: Int) {
        try! realm.write {
            user.checklist.remove(objectAtIndex: index)
        }
    }
    
    func createNewUser() {
        user = User()
        
        // Add placeholder appointments
        user.appointments.append(Appointment(title: "Pre-operative appointment", type: .PreOp))
        user.appointments.append(Appointment(title: "Orthopedic surgeon appointment", type: .Orthopedic))
        user.appointments.append(Appointment(title: "2-week follow up", type: .FollowUp2Week))
        user.appointments.append(Appointment(title: "6-week follow up", type: .FollowUp6Week))
        
        /*
        user.appointments.append(Appointment(title: "12-week follow up", type: .FollowUp12Week, date: Util.getDateFromString("4/19/2017 2:00 pm", format: "MM/dd/yyyy h:mm a")))
        user.appointments.append(Appointment(title: "Past", type: .CheckUp, date: Util.getDateFromString("1/10/2017 2:00 pm", format: "MM/dd/yyyy h:mm a")))
        user.appointments.append(Appointment(title: "Future", type: .CheckUp, date: Util.getDateFromString("1/19/2017 2:00 pm", format: "MM/dd/yyyy h:mm a")))
        */
        
        // Add the checklist
        user.checklist.append(ChecklistItem(text: "Choose a coach"))
        user.checklist.append(ChecklistItem(text: "Check that surgeon's office has up-to-date insurance"))
        user.checklist.append(ChecklistItem(text: "Check if pre-operative history and physical with PCP is needed"))
        user.checklist.append(ChecklistItem(text: "Schedule appointments"))
        user.checklist.append(ChecklistItem(text: "Complete dental work if needed within the next three months"))
        user.checklist.append(ChecklistItem(text: "Secure helpers who will help with housework, laundry, meal prep, and pet care"))
        user.checklist.append(ChecklistItem(text: "Prepare the house"))
        user.checklist.append(ChecklistItem(text: "Arrange for help with errands (grocery shopping, doctor's appointments, etc.)"))
        user.checklist.append(ChecklistItem(text: "Stop smoking"))
        user.checklist.append(ChecklistItem(text: "Complete application for DMV handicapped permit"))
        user.checklist.append(ChecklistItem(text: "Pack your bag"))
        user.checklist.append(ChecklistItem(text: "Fill out medication list"))
        user.checklist.append(ChecklistItem(text: "Fill out Anesthesia Questionnaire"))
        user.checklist.append(ChecklistItem(text: "Plans for discharge questionnaire"))
        user.checklist.append(ChecklistItem(text: "Prepare advanced directive, if available"))
        user.checklist.append(ChecklistItem(text: "Complete Sleep Apnea questionnaire"))
        user.checklist.append(ChecklistItem(text: "Arrange time off for work"))
        user.checklist.append(ChecklistItem(text: "Arrange daycare needs"))
        user.checklist.append(ChecklistItem(text: "Stock up on prepared food"))
        user.checklist.append(ChecklistItem(text: "Arrange for lawn care"))
        user.checklist.append(ChecklistItem(text: ""))
        
        // Save the user object
        try! realm.write {
            realm.add(user)
        }
    }
    
    func resetData() {
        try! realm.write {
            realm.deleteAll()
        }
        
        CarePlanStoreManager.sharedInstance.resetStore()
        
        self.createNewUser()
    }
}
