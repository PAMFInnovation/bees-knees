//
//  AppointmentViewController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/2/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit


protocol AppointmentViewControllerDelegate: class {
    func doneEditingAppointment(sender: AppointmentViewController)
}

class AppointmentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Appointment data
    var appointment: Appointment!
    
    // Subviews
    var scrollView: UIScrollView!
    var tableView: UITableView!
    
    // Keep track of the observed UI item in case we need to make it visible via scrolling
    var activeElement: UIView?
    
    // Table data
    var tableViewData = [AppointmentCellData]()
    
    // Keep default edge insets for when we need to reset scrolling
    var defaultScrollInsets: UIEdgeInsets?
    
    // Track variables for expanding the cells
    var cellExpanded: Bool = false
    var expandedRowIndex = -1
    var cellExpandedHeight: CGFloat = 44
    
    // Appointment VC delegate
    var delegate: AppointmentViewControllerDelegate?
    
    
    // MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        // Create a new appointment object
        appointment = Appointment()
    }
    
    convenience init(appt: Appointment) {
        self.init(nibName: nil, bundle: nil)
        
        // Set an existing appointment object
        self.appointment = appt
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // White background
        self.view.backgroundColor = UIColor.white
        
        // Set the title
        self.title = NSLocalizedString("Event", comment: "")
        
        // Add items to the table view data
        tableViewData.append(AppointmentCellData(name: "titleCell"))
        //tableViewData.append(AppointmentCellData(name: "typeCell"))
        tableViewData.append(AppointmentCellData(name: "dateCell"))
        tableViewData.append(AppointmentCellData(name: "placeCell"))
        tableViewData.append(AppointmentCellData(name: "notesCell"))
        tableViewData.append(AppointmentCellData(name: "plannerCell"))
        
        // Setup the scrollview
        let frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height )
        self.scrollView = UIScrollView(frame: frame)
        self.view.addSubview(scrollView)
        
        // Setup the table view
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height - 120), style: .plain)
        self.tableView.register(TitleTableViewCell.self, forCellReuseIdentifier: tableViewData[0].name)
        //self.tableView.register(AppointmentTypeTableViewCell.self, forCellReuseIdentifier: tableViewData[1].name)
        self.tableView.register(DateTableViewCell.self, forCellReuseIdentifier: tableViewData[1].name)
        self.tableView.register(PlaceTableViewCell.self, forCellReuseIdentifier: tableViewData[2].name)
        self.tableView.register(NotesTableViewCell.self, forCellReuseIdentifier: tableViewData[3].name)
        self.tableView.register(PlanToTableViewCell.self, forCellReuseIdentifier: tableViewData[4].name)
        self.tableView.separatorStyle = .singleLine
        self.tableView.isScrollEnabled = true
        self.tableView.delegate = self
        self.tableView.dataSource = self
        scrollView.addSubview(self.tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Listen to keyboard events so we can reposition scroll items
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardOnScreen), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        center.addObserver(self, selector: #selector(keyboardOffScreen), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Unregister from keyboard events
        let center = NotificationCenter.default
        center.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        center.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Set default scroll insets
        defaultScrollInsets = scrollView.contentInset
        
        // An interactively-dismissed keyboard will dismiss when the user scrolls
        scrollView.keyboardDismissMode = .interactive
    }

    
    // MARK: - Helper functions
    func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func done() {
        // Ensure we have the required data in the appointment
        if appointment.hasRequiredInfo() {
            // Add the appointment to the appointments list
            appointment.scheduled = true
            ProfileManager.sharedInstance.addAppointment(appt: appointment)
            
            // Trigger a completion
            self.dismiss(animated: true, completion: nil)
            self.delegate?.doneEditingAppointment(sender: self)
        }
        else {
            let confirm: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            self.alert(message: "This appointment cannot be saved without setting both Title and Date.", title: "", cancelAction: nil, confirmAction: confirm)
        }
    }
    
    func toggleRow(row: Int) {
        // Get the appointment cell
        let indexPath = IndexPath(row: row, section: 0)
        let cell: AppointmentTableViewCell = tableView.cellForRow(at: indexPath) as! AppointmentTableViewCell
        
        // Don't allow surgery appointment type cell to expand
        if cell is AppointmentTypeTableViewCell && cell.appointment?.type == AppointmentType.Surgery {
            return
        }
        
        // Only proceed if this cell can expand
        if !cell.canExpand {
            return
        }
        
        // Expand the cell
        cell.isExpanded = !cell.isExpanded
        cellExpandedHeight = cell.expandedHeight
        
        // Set local expand variables
        if expandedRowIndex != indexPath.row {
            cellExpanded = true
            expandedRowIndex = indexPath.row
        }
        else {
            cellExpanded = false
            expandedRowIndex = -1
        }
        
        // Perform table view updates
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
    
    
    // MARK: - Table View Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue the cell in order of identifier
        let identifier = self.tableViewData[indexPath.row].name
        
        print("identifier :", identifier)
        let cell: AppointmentTableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! AppointmentTableViewCell
        
        // Set the appointment reference
        cell.appointment = appointment
        
        // Set a delegate for the cells
        cell.delegate = self
        
        // Set expanded height based on text for PlanTo cells.
        if (identifier == "plannerCell") {
            self.tableViewData[indexPath.row].defaultHeight = cell.expandedHeight
        }

        else {
            self.tableViewData[indexPath.row].defaultHeight = cell.defaultHeight
        }
        
        // Return the cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        toggleRow(row: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // If the cell is expanded, set the height
        if indexPath.row == expandedRowIndex && cellExpanded {
            return cellExpandedHeight
        }
        
       // print("heightForRowAt :", self.tableViewData[indexPath.row].defaultHeight)
        
        return self.tableViewData[indexPath.row].defaultHeight
    }
    
    
    // MARK: - Keyboard events
    public func keyboardOnScreen(notification: NSNotification) {
        if activeElement == nil {
            return
        }
        
        // Get the keyboard rectangle so we can offset our scroll view by its size
        let info: NSDictionary = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIKeyboardFrameBeginUserInfoKey) as? NSValue)?.cgRectValue.size
        
        // Set the content insets of the scroll view using the keyboard's height
        var contentInsets:UIEdgeInsets = defaultScrollInsets!
        contentInsets.bottom += kbSize!.height
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        
        //--- If the text area collides with the keyboard, we need to move it in view ---//
        // Get the bounds of the view that we can see, excluding the space occupied by the keyboard
        var aRect: CGRect = UIScreen.main.bounds
        aRect.size.height -= (kbSize?.height)!
        
        // Convert the text view's center to the root view's coordinate system
        // We need to do this because we are checking the absolute position of
        // the text area against the screen bounds
        let textAreaCenter: CGPoint = CGPoint(x: (self.activeElement?.frame.midX)!, y: (self.activeElement?.frame.midY)!)
        let convertedPoint: CGPoint = (self.activeElement?.superview?.convert(textAreaCenter, to: self.view))!
        
        // If the visible space does not contain the converted point, we need to scroll it in view
        if (!aRect.contains(convertedPoint)) {
            let scrollPoint:CGPoint = CGPoint(x: 0.0, y: self.scrollView.contentOffset.y + convertedPoint.y - kbSize!.height)
            self.scrollView.setContentOffset(scrollPoint, animated: true)
        }
    }
    
    public func keyboardOffScreen(notification: NSNotification) {
        // Reset the scroll view insets
        scrollView.contentInset = defaultScrollInsets!
        scrollView.scrollIndicatorInsets = defaultScrollInsets!
    }
}

extension AppointmentViewController: AppointmentTableViewCellDelegate {
    func beginEditing(sender: UIView) {
        activeElement = sender
    }
    
    func toggleExpand(sender: AppointmentTableViewCell) {
        for (index, element) in self.tableViewData.enumerated() {
            if element.name == sender.reuseIdentifier! {
                self.toggleRow(row: index)
                return
            }
        }
    }
}
