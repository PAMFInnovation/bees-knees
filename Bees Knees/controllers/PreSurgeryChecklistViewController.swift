//
//  PreOpChecklistViewController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 10/31/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit


class PreSurgeryChecklistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var countdownView: SurgeryCountdown!
    var tableView: UITableView!
    var tableViewData = [ChecklistItem]()
    
    
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
        tableViewData.append(ChecklistItem(text: "Item 1"))
        tableViewData.append(ChecklistItem(text: "Item 2"))
        tableViewData.append(ChecklistItem(text: "Item 3"))
        tableViewData.append(ChecklistItem(text: "Item 4"))
        tableViewData.append(ChecklistItem(text: "Item 5"))
        tableViewData.append(ChecklistItem(text: ""))
        
        // Setup the countdown view
        self.countdownView = SurgeryCountdown(frame: CGRect(x: 0, y: 60, width: self.view.bounds.size.width, height: 80))
        self.view.addSubview(countdownView)
        
        // Setup the table view
        self.tableView = UITableView(frame: CGRect(x: 0, y: 140, width: self.view.bounds.size.width, height: self.view.bounds.size.height - 80), style: .plain)
        self.tableView.register(ChecklistItemTableViewCell.self, forCellReuseIdentifier: "myCell")
        self.tableView.separatorStyle = .singleLine
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
        
        // Set the custom cell delegate
        cell.delegate = self
        
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
}

extension PreSurgeryChecklistViewController: ChecklistItemTableViewCellDelegate {
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
    }
}
