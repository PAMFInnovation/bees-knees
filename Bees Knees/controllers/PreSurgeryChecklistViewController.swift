//
//  PreOpChecklistViewController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 10/31/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit


class PreSurgeryChecklistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Subviews
    var scrollView: UIScrollView!
    var countdownView: SurgeryCountdown!
    var tableView: UITableView!
    
    // Table data
    var tableViewData = [ChecklistItem]()
    
    // Keep track of the observed UI item in case we need to make it visible via scrolling
    var activeElement: UIControl?
    
    // Keep default edge insets for when we need to reset scrolling
    var defaultScrollInsets: UIEdgeInsets?
    
    
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
        
        // Add items to the table view data
        tableViewData.append(ChecklistItem(text: "Choose a coach"))
        tableViewData.append(ChecklistItem(text: "Check that surgeon's office has up-to-date insurance"))
        tableViewData.append(ChecklistItem(text: "Check if pre-operative history and physical with PCP is needed"))
        tableViewData.append(ChecklistItem(text: "Schedule appointments"))
        tableViewData.append(ChecklistItem(text: "Complete dental work if needed within the next three months"))
        tableViewData.append(ChecklistItem(text: "Secure helpers who will help with housework, laundry, meal prep, and pet care"))
        tableViewData.append(ChecklistItem(text: "Prepare the house"))
        tableViewData.append(ChecklistItem(text: "Arrange for help with errands (grocery shopping, doctor's appointments, etc.)"))
        tableViewData.append(ChecklistItem(text: "Stop smoking"))
        tableViewData.append(ChecklistItem(text: "Complete application for DMV handicapped permit"))
        tableViewData.append(ChecklistItem(text: "Pack your bag"))
        tableViewData.append(ChecklistItem(text: "Fill out medication list"))
        tableViewData.append(ChecklistItem(text: "Fill out Anesthesia Questionnaire"))
        tableViewData.append(ChecklistItem(text: "Plans for discharge questionnaire"))
        tableViewData.append(ChecklistItem(text: "Prepare advanced directive, if available"))
        tableViewData.append(ChecklistItem(text: "Complete Sleep Apnea questionnaire"))
        tableViewData.append(ChecklistItem(text: "Arrange time off for work"))
        tableViewData.append(ChecklistItem(text: "Arrange daycare needs"))
        tableViewData.append(ChecklistItem(text: "Stock up on prepared food"))
        tableViewData.append(ChecklistItem(text: "Arrange for lawn care"))
        tableViewData.append(ChecklistItem(text: ""))
        
        // Setup the scrollview
        self.scrollView = UIScrollView(frame: self.view.frame)
        self.view.addSubview(scrollView)
        
        // Setup the countdown view
        self.countdownView = SurgeryCountdown(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 80))
        scrollView.addSubview(countdownView)
        
        // Setup the table view
        self.tableView = UITableView(frame: CGRect(x: 0, y: 80, width: self.view.bounds.size.width, height: self.view.bounds.size.height - 200), style: .plain)
        self.tableView.register(ChecklistItemTableViewCell.self, forCellReuseIdentifier: "myCell")
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
        
        // Update the surgery label
        self.countdownView.updateSurgeryLabel()
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
    
    
    // MARK: - Table View Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Set text and index on the custom cell
        let cell: ChecklistItemTableViewCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! ChecklistItemTableViewCell
        let item: ChecklistItem = self.tableViewData[indexPath.row]
        cell.itemField.text = item.text
        cell.checklistItem = item
        
        // Disable the final checklist item to give it a "+" icon
        if indexPath.row == tableViewData.count - 1 {
            cell.disable()
        }
        else {
            cell.enable()
        }
        
        // Set the custom cell delegate
        cell.delegate = self
        
        // Return the cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let _self = self
        let delete = UITableViewRowAction(style: .normal, title: "Delete", handler: {_,_ in 
            // Remove the cell from the table view's data
            _self.tableViewData.remove(at: indexPath.row)
            
            // Remove the cell from the table view's data
            _self.tableView.beginUpdates()
            let indexPathForRow = NSIndexPath(row: indexPath.row, section: 0)
            _self.tableView.deleteRows(at: [indexPathForRow as IndexPath], with: .fade)
            _self.tableView.endUpdates()
        })
        delete.backgroundColor = UIColor.red
        
        return [delete]
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Ignore for the final element
        if indexPath.row == tableViewData.count - 1 {
            return false
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // This block is required for cell swipe menu to appear
    }
    
    
    // MARK: - Keyboard events
    public func keyboardOnScreen(notification: NSNotification) {
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

extension PreSurgeryChecklistViewController: ChecklistItemTableViewCellDelegate {
    func beginEditing(element: UIControl) {
        activeElement = element
    }
    
    func doneEditing(sender: ChecklistItemTableViewCell, item: ChecklistItem) {
        // Get the index of the cell to edit
        let index = (tableViewData as NSArray).index(of: item)
        if index == NSNotFound {
            return
        }
        
        // Update the text for the cell at sender's index
        self.tableViewData[index].text = sender.itemField.text!
        
        // If we modified the last item, create a new one with empty string
        if index == tableViewData.count - 1 && sender.itemField.text != "" {
            tableViewData.append(ChecklistItem(text: ""))
        }
        
        // Reload the table data
        self.tableView.reloadData()
        
        // Close the keyboard
        self.view.endEditing(true)
    }
}
