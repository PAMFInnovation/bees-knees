//
//  DateTableViewCell.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/2/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit


class DateTableViewCell: AppointmentTableViewCell, UIPickerViewDelegate {
    
    var hRule: HorizontalRule!
    var datePicker = UIDatePicker()
    var noDateLabel = UILabel()
    var dateLabel = UILabel()
    
    
    // MARK: - Initialization
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        // Parent init
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // No selection style
        self.selectionStyle = .none
        
        // Set label text
        self.label.text = "When"
        
        // This cell can expand
        canExpand = true
        expandedHeight = 244
        
        // Set "no date" label
        noDateLabel.text = "Date Not Set"
        noDateLabel.textColor = UIColor.lightGray
        noDateLabel.isHidden = false
        noDateLabel.frame = CGRect(x: self.label.frame.maxX, y: 0, width: self.frame.width - self.label.frame.maxX, height: self.frame.height)
        self.addSubview(noDateLabel)
        
        // Set the date label
        dateLabel.text = ""
        dateLabel.textColor = UIColor.gray
        dateLabel.isHidden = true
        dateLabel.frame = CGRect(x: self.label.frame.maxX, y: 0, width: self.frame.width - self.label.frame.maxX, height: self.frame.height)
        self.addSubview(dateLabel)
        
        // Add a horizontal rule
        hRule = HorizontalRule(x: 15, y: label.frame.height, width: self.frame.width)
        self.addSubview(hRule)
        
        // Add the date picker
        datePicker.frame = CGRect(x: 0, y: label.frame.height, width: self.frame.width, height: 200)
        datePicker.addTarget(self, action: #selector(DateTableViewCell.didChangeDate), for: .valueChanged)
        self.addSubview(datePicker)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Update the width of the views
        hRule.frame = CGRect(x: hRule.frame.minX, y: hRule.frame.minY, width: self.frame.width, height: hRule.frame.height)
        datePicker.frame = CGRect(x: datePicker.frame.minX, y: datePicker.frame.minY, width: self.frame.width, height: datePicker.frame.height)
    }
    
    
    // MARK: - helper functions
    func didChangeDate(sender: UIDatePicker) {
        // Format the date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.short
        let dateString = dateFormatter.string(from: sender.date)
        
        // Set the date label data
        noDateLabel.isHidden = true
        dateLabel.isHidden = false
        dateLabel.text = dateString
    }
}
