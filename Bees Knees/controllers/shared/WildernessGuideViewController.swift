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
    
    // Paths
    var dottedPath: MyPath!
    var solidPath: MyPath!
    var pathOffset: CGPoint = CGPoint(x: 43, y: 35)
    var shouldRenderPath: Bool = true
    
    
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
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.red
        
        // Setup the scrollview
        self.scrollView = UIScrollView(frame: self.view.frame)
        self.view.addSubview(scrollView)
        
        // Setup the countdown view
        self.countdownView = SurgeryCountdown(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 80))
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
        
        // Add the line paths
        dottedPath = MyPath(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height), isDashed: true)
        solidPath = MyPath(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height), isDashed: false)
        
        // Insert the line path subview as the first view in the table view
        // This ensures it renders underneath the cells themselves
        self.tableView.insertSubview(solidPath, at: 0)
        self.tableView.insertSubview(dottedPath, at: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Update the surgery label
        self.countdownView.updateSurgeryLabel()
        
        // Ensure we rerender the path
        shouldRenderPath = true
        
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
        apptVC.navigationItem.leftBarButtonItem?.tintColor = UIColor.red
        
        // Add the done button in the navigation bar and color it
        apptVC.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: apptVC, action: #selector(AppointmentViewController.done))
        apptVC.navigationItem.rightBarButtonItem?.tintColor = UIColor.red
        
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
        cell.setAppointment(appointment: appt)
        
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
        
        // Redraw the dotted/solid paths
        self.redrawPaths()
    }
    
    func populateTable() {
        // Add the appointments
        self.tableViewData = ProfileManager.sharedInstance.appointments
        
        // Add the surgery date to the table
        if ProfileManager.sharedInstance.isSurgerySet {
            self.tableViewData.append(ProfileManager.sharedInstance.surgeryAppointment)
        }
        
        // Sort the table
        self.tableViewData.sort(by: { $0.date! < $1.date! })
        
        // Track the next appointment
        nextAppointment = nil
        var found: Bool = false
        for appt in self.tableViewData {
            appt.elapsed = Util.isDateInPast(appt.date!)
            
            if !found && !appt.elapsed {
                nextAppointment = appt
                found = true
            }
        }
    }
    
    func redrawPaths() {
        if shouldRenderPath {
            // Find the path lengths
            var dashedPathLength: CGFloat = 0
            var solidPathLength: CGFloat = 0
            var previousCellLength: CGFloat = 0
            for (index, cell) in self.tableViewData.enumerated() {
                // Get the cell height
                let height = self.getHeightForCell(index: index)
                
                // Ignore the last cell's height
                if index < self.tableViewData.count - 1 {
                    // Always increment dashes path length
                    dashedPathLength = dashedPathLength + height
                    
                    // Only increment solid path length if the cell is elapsed
                    if (cell as Appointment).elapsed! {
                        solidPathLength = solidPathLength + previousCellLength
                    }
                }
                
                // Set the previous cell length for solid paths
                previousCellLength = height
            }
            
            // Update the height of the path views to accommodate the accumulated height
            // Add previous cell length since we left that out of the overall height
            dottedPath.frame.size = CGSize(width: dottedPath.frame.size.width, height: dashedPathLength + previousCellLength)
            solidPath.frame.size = CGSize(width: dottedPath.frame.size.width, height: dashedPathLength + previousCellLength)
            
            // The starting path for both lines will always be the offset
            dottedPath.setStartPoint(pathOffset)
            solidPath.setStartPoint(pathOffset)
            
            // The ending path for the dotted line will be based on the path length, calculated from the accumulated height of all cells
            dottedPath.setEndPoint(CGPoint(x: pathOffset.x, y: pathOffset.y + dashedPathLength))
            
            // The ending path for the solid line will be based on the solid path length, calculated from the accumulated height of all elapsed cells
            solidPath.setEndPoint(CGPoint(x: pathOffset.x, y: pathOffset.y + solidPathLength))
            
            // Trigger a draw on the next frame
            dottedPath.setNeedsDisplay()
            solidPath.setNeedsDisplay()
            
            // Reset render state
            shouldRenderPath = false
        }
    }
    
    private func getHeightForCell(index: Int) -> CGFloat {
        let appt = self.tableViewData[index] as Appointment
        
        // Get the height of the cell
        var height: CGFloat = 66.0
        if appt.type == AppointmentType.Surgery {
            height = appt == nextAppointment ? 215 : 86
        }
        else if appt.type == AppointmentType.CheckUp || appt.type == AppointmentType.Consultation {
            height = 66
        }
        else {
            height = appt == nextAppointment ? 185 : 66
        }
        
        return height
    }
}

extension WildernessGuideViewController: AppointmentViewControllerDelegate {
    func doneEditingAppointment(sender: AppointmentViewController) {
        self.reloadTable()
    }
}
