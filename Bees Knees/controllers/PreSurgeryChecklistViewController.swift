//
//  PreOpChecklistViewController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 10/31/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit


class PreSurgeryChecklistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView!
    var tableViewData = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", ""]
    
    
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
        
        // Setup the table view
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height), style: .plain)
        self.tableView.register(ChecklistItem.self, forCellReuseIdentifier: "myCell")
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Set text and index on the custom cell
        let cell: ChecklistItem = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! ChecklistItem
        cell.itemField.text = self.tableViewData[indexPath.row]
        cell.index = indexPath.row
        
        // Disable the final checklist item to give it a "+" icon
        if indexPath.row == tableViewData.count - 1 {
            cell.disable()
        }
        
        // Set the custom cell delegate
        cell.delegate = self
        
        return cell
    }
}

extension PreSurgeryChecklistViewController: ChecklistItemDelegate {
    func doneEditing(sender: ChecklistItem) {
        // Update the text for the cell at sender's index
        self.tableViewData[sender.index] = sender.itemField.text!
        
        // If we modified the last item, create a new one with empty string
        if sender.index == tableViewData.count - 1 && sender.itemField.text != "" {
            tableViewData.append("")
        }
        
        // Reload the table data
        self.tableView.reloadData()
    }
}
