//
//  AppointmentTypeTableViewCell.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/2/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit


class AppointmentTypeTableViewCell: AppointmentTableViewCell, UITableViewDelegate, UITableViewDataSource {
    
    var hRule: HorizontalRule!
    var tableView: UITableView!
    var tableViewData: [String] = ["Check up", "Consultation", "6 week check-in", "12 week check-in"]
    var selectedCell: IndexPath = IndexPath(row: 0, section: 0)
    var selectionLabel = UILabel()
    
    
    // MARK: - Initialization
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // No selection style
        self.selectionStyle = .none
        
        // Set label text
        self.label.text = "Type"
        
        // This cell can expand
        canExpand = true
        expandedHeight = CGFloat(44.0) * CGFloat(tableViewData.count + 1)
        
        // Set the date label
        selectionLabel.text = self.tableViewData[selectedCell.row]
        selectionLabel.textColor = UIColor.gray
        selectionLabel.frame = CGRect(x: self.label.frame.maxX, y: 0, width: self.frame.width - self.label.frame.maxX, height: self.frame.height)
        self.addSubview(selectionLabel)
        
        // Add a horizontal rule
        hRule = HorizontalRule(x: 15, y: label.frame.height, width: self.frame.width)
        self.addSubview(hRule)
        
        // Setup the table view
        self.tableView = UITableView(frame: CGRect(x: self.label.frame.width, y: label.frame.height + 1, width: self.frame.width - self.label.frame.width, height: expandedHeight - 44), style: .plain)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        self.tableView.separatorStyle = .singleLine
        self.tableView.contentInset = UIEdgeInsets.zero
        self.tableView.scrollIndicatorInsets = UIEdgeInsets.zero
        self.tableView.isScrollEnabled = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.addSubview(self.tableView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Update the width of the views
        hRule.frame = CGRect(x: hRule.frame.minX, y: hRule.frame.minY, width: self.frame.width, height: hRule.frame.height)
        tableView.frame = CGRect(x: tableView.frame.minX, y: tableView.frame.minY, width: self.frame.width - self.label.frame.width, height: tableView.frame.height)
    }
    
    
    // MARK: - Table View Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue the cell
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = self.tableViewData[indexPath.row]
        cell.textLabel?.textColor = UIColor.lightGray
        cell.selectionStyle = .none
        
        // If this cell is selected, show the accessory
        if indexPath.row == selectedCell.row {
            cell.accessoryType = .checkmark
        }
        
        // Return the cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Ignore when the current cell is the next cell
        if selectedCell == indexPath {
            return
        }
        
        // Deselect current cell
        let currentCell: UITableViewCell = tableView.cellForRow(at: selectedCell)!
        currentCell.accessoryType = .none
        
        // Select next cell
        selectedCell = indexPath
        let nextCell: UITableViewCell = tableView.cellForRow(at: selectedCell)!
        nextCell.accessoryType = .checkmark
        
        // Set the display text
        selectionLabel.text = self.tableViewData[selectedCell.row]
    }
}
