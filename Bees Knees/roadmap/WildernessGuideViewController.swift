//
//  WildernessGuideViewController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/2/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit


class WildernessGuideViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Subviews
    var scrollView: UIScrollView!
    var countdownView: SurgeryCountdown!
    var tableView: UITableView!
    
    // Table data
    var tableViewData = [Appointment]()
    var nextAppointment: Appointment?
    
    
    // MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Populate the table
        self.populateTable()
        
        // Add the + button in the navigation bar and color it
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(WildernessGuideViewController.newAppointment))
        
        // Setup the scrollview
        self.scrollView = UIScrollView(frame: self.view.frame)
        self.view.addSubview(scrollView)
        
        // Setup the countdown view
        self.countdownView = SurgeryCountdown(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 80))
        self.countdownView.delegate = self
        scrollView.addSubview(countdownView)
        
        // Setup the table view
        self.tableView = UITableView(frame: CGRect(x: 0, y: 80, width: self.view.bounds.size.width, height: self.view.bounds.size.height - 200), style: .plain)
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.register(GuideTableViewCell.self, forCellReuseIdentifier: "myCell")
        self.tableView.separatorStyle = .singleLine
        self.tableView.isScrollEnabled = true
        self.tableView.delegate = self
        self.tableView.dataSource = self
        scrollView.addSubview(self.tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Update the surgery label
        self.countdownView.updateSurgeryLabel()
        
        // Reload the table
        self.reloadTable()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    
    // MARK: - Helper functions
    func newAppointment() {
        // Present the Appointments view controller
        let apptVC = AppointmentViewController()
        apptVC.delegate = self
        
        // Add the cancel button in the navigation bar and color it
        apptVC.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: apptVC, action: #selector(AppointmentViewController.cancel))
        
        // Add the done button in the navigation bar and color it
        apptVC.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .done, target: apptVC, action: #selector(AppointmentViewController.done))
        
        // Present this modal view controller
        let navVC = UINavigationController(rootViewController: apptVC)
        self.present(navVC, animated: true, completion: nil)
    }
    
    func openAppointment(_ appt: Appointment) {
        // Present the Appointments view controller
        let apptVC = AppointmentViewController(appt: appt)
        
        // Push this navigation controller
        self.navigationController?.pushViewController(apptVC, animated: true)
    }
    
    
    // MARK: - Table View Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.getHeightForCell(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Set text and index on the custom cell
        let cell: GuideTableViewCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! GuideTableViewCell
        
        // Set the appointment on the cell
        let appt: Appointment = self.tableViewData[indexPath.row] as Appointment
        cell.setAppointment(appointment: appt, isNextAppointment: appt == nextAppointment)
        
        // Set the disclosure
        cell.accessoryType = .disclosureIndicator
        
        // Return the cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Open the appointment
        self.openAppointment(self.tableViewData[indexPath.row])
    }
    
    func reloadTable() {
        // Populate the table with appointments and surgery, then sort it
        self.populateTable()
        
        // Reload the table
        self.tableView.reloadData()
    }
    
    func populateTable() {
        // Reset the appointments list
        self.tableViewData = []
        
        // Check for specific appointments
        var consultation: Appointment? = nil
        var preOpAppt: Appointment? = nil
        var orthoAppt: Appointment? = nil
        var followUp2Appt: Appointment? = nil
        var followUp6Appt: Appointment? = nil
        
        // Add the appointments
        var appts: [Appointment] = []
        for appt in ProfileManager.sharedInstance.getAppointments() {
            if appt.scheduled == true {
                appts.append(appt)
            }
            
            if appt.type == AppointmentType.Consultation {
                consultation = appt
            }
            if appt.type == AppointmentType.PreOp {
                preOpAppt = appt
            }
            if appt.type == AppointmentType.Orthopedic {
                orthoAppt = appt
            }
            if appt.type == AppointmentType.FollowUp2Week {
                followUp2Appt = appt
            }
            if appt.type == AppointmentType.FollowUp6Week {
                followUp6Appt = appt
            }
        }
        
        // Add the scheduled appointments
        /*for appt in appts {
            self.tableViewData.append(appt)
        }*/
        self.tableViewData = appts
        
        // Add the surgery date to the table
        if ProfileManager.sharedInstance.isSurgerySet() {
            self.tableViewData.append(ProfileManager.sharedInstance.getSurgeryAppointment())
        }
        
        // Sort the table
        self.tableViewData.sort(by: { $0.date < $1.date })
        
        
        // Add the Follow Up slots  if it hasn't been scheduled and surgery has elapsed
        if ProfileManager.sharedInstance.isSurgerySet() == true &&
            Util.isDateInPast(ProfileManager.sharedInstance.getSurgeryDate()) == true {
            
            if followUp6Appt != nil && followUp6Appt?.scheduled == false {
                self.tableViewData.insert(followUp6Appt!, at: 0)
            }
            if followUp2Appt != nil && followUp2Appt?.scheduled == false {
                self.tableViewData.insert(followUp2Appt!, at: 0)
            }
        }
        
        // Add the surgery slot if it hasn't been scheduled
        if ProfileManager.sharedInstance.isSurgerySet() == false {
            self.tableViewData.insert(ProfileManager.sharedInstance.getSurgeryAppointment(), at: 0)
        }
            
        // Only add Pre-Op and Ortho slots if they haven't been scheduled and the surgery date hasn't elapsed
        if ProfileManager.sharedInstance.isSurgerySet() &&
            Util.isDateInPast(ProfileManager.sharedInstance.getSurgeryDate()) == false {
            
            if orthoAppt != nil && orthoAppt?.scheduled == false {
                self.tableViewData.insert(orthoAppt!, at: 0)
            }
            if preOpAppt != nil && preOpAppt?.scheduled == false {
                self.tableViewData.insert(preOpAppt!, at: 0)
            }
            // Adding consultation type for MPHS
            if consultation != nil && consultation?.scheduled == false {
                self.tableViewData.insert(consultation!, at: 0)
            }
        }
        
        
        // Track the next appointment
        nextAppointment = nil
        var found: Bool = false
        for appt in self.tableViewData {
            if appt.scheduled == true {
                appt.updateElapsed()
                
                if !found && !appt.elapsed {
                    nextAppointment = appt
                    found = true
                }
            }
        }
    }
    
    private func getHeightForCell(index: Int) -> CGFloat {
        let appt = self.tableViewData[index] as Appointment
        
        // Get the height of the cell
        var height: CGFloat = 66.0
        if appt.scheduled == false {
            height = 66.0
        }
        else if (appt.type == AppointmentType.Surgery || appt.type == AppointmentType.PreOp ||
            appt.type == AppointmentType.Orthopedic || appt.type  == AppointmentType.Consultation) {
            //height = appt == nextAppointment ? 215 : 86
            height = appt == nextAppointment ? 200 : height
        }
        else if appt.type == AppointmentType.CheckUp  {
            //height = height
        }
        else {
            height = appt == nextAppointment ? 175 : height
        }
        
        return height
    }
}

extension WildernessGuideViewController: AppointmentViewControllerDelegate {
    func doneEditingAppointment(sender: AppointmentViewController) {
        self.reloadTable()
    }
}

extension WildernessGuideViewController: SurgeryCountdownDelegate {
    func tapEditSurgeryDate(sender: SurgeryCountdown) {
        let dateOfSurgeryVC = DateOfSurgeryViewController()
        dateOfSurgeryVC.title = NSLocalizedString("Adjust Date", comment: "")
        self.navigationController?.pushViewController(dateOfSurgeryVC, animated: true)
    }
}
