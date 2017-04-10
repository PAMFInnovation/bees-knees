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
    
    // Surgery location
    dynamic var surgeryLocation: String = ""
    
    // Signed consent data
    dynamic var didConsent: Bool = false
    dynamic var consentData: Data = Data()
    
    // Appointments
    let appointments = List<Appointment>()
    
    // Surgery appointment
    dynamic var surgeryAppointment: Appointment? = Appointment(title: "Surgery", type: AppointmentType.Surgery)
    dynamic var isSurgerySet: Bool = false
    
    // Flow Start Dates
    dynamic var preSurgeryStartDate: Date = Date()
    dynamic var postSurgeryStartDate: Date = Date()
    
    // Checklist
    let checklist = List<ChecklistItem>()
    
    // Plan To
    var planTo = List<PlanToItem>()
    
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
            schemaVersion: 3,
            migrationBlock: { migration, oldSchemaVersion in
                migration.enumerateObjects(ofType: User.className(), { oldObject, newObject in
                    // Version 1 changes:
                    // added didConsent: Bool
                    if oldSchemaVersion < 1 {
                        let state = (oldObject!["flowState"] as! Int)
                        var didConsent = false
                        if state != 0 && state != 1 {
                            didConsent = true
                        }
                        newObject!["didConsent"] = didConsent
                    }
                    
                    // Version 2 changes:
                    // added postSurgeryStartDate: Date
                    if oldSchemaVersion < 2 {
                        newObject!["preSurgeryStartDate"] = Date()
                        newObject!["postSurgeryStartDate"] = Date()
                    }
                    
                    // Version 3 changes:
                    // added surgeryLocation: String
                    if oldSchemaVersion < 3 {
                        newObject!["surgeryLocation"] = ""
                    }
                })
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
    
    // List of locations and current location
    var surgeryLocations: [LocationModel]?
    var userLocation: LocationContentModel?
    
    
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
    
    func getPreSurgeryStartDate() -> Date {
        return user.preSurgeryStartDate
    }
    
    func setPreSurgeryStartDate(_ date: Date) {
        try! realm.write {
            user.preSurgeryStartDate = date
        }
    }
    
    func getPostSurgeryStartDate() -> Date {
        return user.postSurgeryStartDate
    }
    
    func setPostSurgeryStartDate(_ date: Date) {
        try! realm.write {
            user.postSurgeryStartDate = date
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
    
    func getSurgeryLocation() -> String {
        return user.surgeryLocation
    }
    
    func setSurgeryLocation(_ surgeryLocation: String) {
        try! realm.write {
            user.surgeryLocation = surgeryLocation
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
    
    func getPlanTo(appointmentType: String) -> String {
        for planToRecord in user.planTo {
            if(planToRecord.appointmentType == appointmentType) {
                return planToRecord.planToItems
            }
        }
        return ""
    }
    
    func addPlanTo(item: PlanToItem) {
        try! realm.write {
            user.planTo.append(item)
        }
    }
    func getLocations() -> [LocationModel] {
        if surgeryLocations == nil {
            surgeryLocations = []
            let locationsModel = (Util.getJSONForResource(resource: "locations") as LocationsCollectionModel)
            addLocations(locationsModel)
        }
        return surgeryLocations!
    }
    
    func addLocations(_ locations: LocationsCollectionModel) {
        for location in locations.locations {
            surgeryLocations?.append(location)
        }
    }
    
    func getUserLocation() -> LocationContentModel {
        if userLocation == nil {
            userLocation = (Util.getJSONForResource(resource: user.surgeryLocation) as LocationContentModel)
        }
        return userLocation!
    }
    
    func loadLocationContent() {
        let location = getUserLocation()
        
        //
        // Activities
        //
        CarePlanStoreManager.sharedInstance.addBaseActivities(location.activities)
        
        // Add the location content
        try! realm.write {
            //
            // Appointments
            //
            for appointment in location.appointments {
                user.appointments.append(Appointment(title: appointment.title, type: AppointmentType.getEnumFromString(string: appointment.type)!))
            }
            
            //
            // Checklist
            //
            for checklistItem in location.checklist {
                user.checklist.append(ChecklistItem(text: checklistItem))
            }
            // Append an empty string ChecklistItem which serves as the "add" cell
            user.checklist.append(ChecklistItem(text: ""))
            
            // set Plan To data
            for planToItem in location.planTo {
                user.planTo.append(PlanToItem(appointmentType: planToItem.appointmentType, planToItems: planToItem.planToItems))
            }        }
    }
    
    func createNewUser() {
        user = User()
        
        // Reset location data
        userLocation = nil
        
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
