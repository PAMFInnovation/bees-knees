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
    dynamic var didConsent: Bool = false
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
        
        // Set the configuration
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                // Version 1 changes:
                // added didConsent: Bool
                if oldSchemaVersion == 0 {
                    migration.enumerateObjects(ofType: User.className(), { oldObject, newObject in
                        let state = (oldObject!["flowState"] as! Int)
                        var didConsent = false
                        if state != 0 && state != 1 {
                            didConsent = true
                        }
                        newObject!["didConsent"] = didConsent
                    })
                }
            }
        )
        Realm.Configuration.defaultConfiguration = config
        
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
    
    func getSignedConsentDocument() -> Data? {
        if user.didConsent {
            return user.consentData
        }
        else {
            return nil
        }
    }
    
    func updateSignedConsentDocument(data: Data) {
        try! realm.write {
            user.didConsent = true
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
        user.appointments.append(Appointment(title: "Follow up", type: .FollowUp2Week))
        //user.appointments.append(Appointment(title: "6-week follow up", type: .FollowUp6Week))
        
        /*
        user.appointments.append(Appointment(title: "12-week follow up", type: .FollowUp12Week, date: Util.getDateFromString("4/19/2017 2:00 pm", format: "MM/dd/yyyy h:mm a")))
        user.appointments.append(Appointment(title: "Past", type: .CheckUp, date: Util.getDateFromString("1/10/2017 2:00 pm", format: "MM/dd/yyyy h:mm a")))
        user.appointments.append(Appointment(title: "Future", type: .CheckUp, date: Util.getDateFromString("1/19/2017 2:00 pm", format: "MM/dd/yyyy h:mm a")))
        */
        
        // Add the checklist
        user.checklist.append(ChecklistItem(text: "Verify insurance with surgeon's office"))
        user.checklist.append(ChecklistItem(text: "Schedule out appointments"))
        user.checklist.append(ChecklistItem(text: "Complete dental work 3 months before"))
        user.checklist.append(ChecklistItem(text: "Arrange time off from work, if needed"))
        user.checklist.append(ChecklistItem(text: "Fill out medication list"))
        user.checklist.append(ChecklistItem(text: "Fill out Anesthesia Questionnaire"))
        user.checklist.append(ChecklistItem(text: "Fill out Plans of Discharge Form"))
        user.checklist.append(ChecklistItem(text: "Prepare advanced directive, if desired"))
        user.checklist.append(ChecklistItem(text: "Fill out Sleep Apnea Questionnaire"))
        user.checklist.append(ChecklistItem(text: "Complete DMV handicap application"))
        user.checklist.append(ChecklistItem(text: "Stop smoking, if applicable"))
        user.checklist.append(ChecklistItem(text: "Find helpers for housework/meals/pets"))
        user.checklist.append(ChecklistItem(text: "Arrange help with transportation"))
        user.checklist.append(ChecklistItem(text: "Arrange day care needs, if needed"))
        user.checklist.append(ChecklistItem(text: "Prepare food or arrange meal-delivery"))
        user.checklist.append(ChecklistItem(text: "Arrange for lawn care, if needed"))
        user.checklist.append(ChecklistItem(text: "See \"Preparing for your return home\""))
        user.checklist.append(ChecklistItem(text: "Reorganize storage to easily access"))
        user.checklist.append(ChecklistItem(text: "Move items to lower fridge shelves"))
        user.checklist.append(ChecklistItem(text: "Remove and store rugs to avoid snags"))
        user.checklist.append(ChecklistItem(text: "Clear clutter/cords from walkways"))
        user.checklist.append(ChecklistItem(text: "Have a sleeping area on 1st floor"))
        user.checklist.append(ChecklistItem(text: "Ensure non-slip surfaces in bathtub"))
        user.checklist.append(ChecklistItem(text: "Secure handrails on stairs and tub"))
        user.checklist.append(ChecklistItem(text: "Pack your bag"))
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
