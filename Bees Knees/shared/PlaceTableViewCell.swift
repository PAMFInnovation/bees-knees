//
//  PlaceTableViewCell.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/2/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit
import MapKit


protocol PlaceTableViewCellDelegate: class {
    func toggleExpand(sender: PlaceTableViewCell)
}

class PlaceTableViewCell: AppointmentTableViewCell, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var hRule: HorizontalRule!
    var addressField = UITextField()
    var tableView: UITableView!
    
    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    
    var delegate: PlaceTableViewCellDelegate?
    
    
    // MARK: - Initialization
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // No selection style
        self.selectionStyle = .none
        
        // Set label text
        self.label.text = "Where"
        
        // This cell can expand
        canExpand = true
        expandedHeight = 244
        
        // Set the search completer delegate
        searchCompleter.delegate = self
        
        // Add a horizontal rule
        hRule = HorizontalRule(x: 15, y: label.frame.height, width: self.frame.width)
        self.addSubview(hRule)
        
        // Add the address text field
        addressField.frame = CGRect(x: self.label.frame.maxX, y: 0, width: self.frame.width - self.label.frame.maxX, height: self.frame.height)
        addressField.tintColor = UIColor.gray
        addressField.textColor = UIColor.gray
        addressField.returnKeyType = .done
        addressField.delegate = self
        addressField.addTarget(self, action: #selector(PlaceTableViewCell.textChanged), for: .editingChanged)
        self.addSubview(addressField)
        
        // Setup the table view
        self.tableView = UITableView(frame: CGRect(x: self.label.frame.width, y: label.frame.height + 1, width: self.frame.width - self.label.frame.width, height: 200), style: .plain)
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
    
    
    // MARK: - Helper functions
    func textChanged(sender: UITextField) {
        searchCompleter.queryFragment = addressField.text!
    }
    
    
    // MARK: - Text Field Delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Close the keyboard and table
        self.endEditing(true)
        if isExpanded {
            delegate?.toggleExpand(sender: self)
        }
        return true
    }
    
    
    // MARK: - Table View Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Result
        let searchResult = searchResults[indexPath.row]
        
        // Set a subtitle cell
        let cell: UITableViewCell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.subtitle
        
        // Return the cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Result
        let searchResult = searchResults[indexPath.row]
        
        // Set the address text
        addressField.text = searchResult.title + " " + searchResult.subtitle
        
        // Close the keyboard and table
        self.endEditing(true)
        if isExpanded {
            delegate?.toggleExpand(sender: self)
        }
    }
}

extension PlaceTableViewCell: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        // Display the results in the table
        searchResults = completer.results
        tableView.reloadData()
        
        // Expand the table
        if !isExpanded {
            delegate?.toggleExpand(sender: self)
        }
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print("error in completer")
    }
}
