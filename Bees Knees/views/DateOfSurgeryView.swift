//
//  DateOfSurgeryView.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 10/27/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import Foundation
import UIKit


class DateOfSurgeryView: UIView {
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "DateOfSurgeryInterface", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    @IBOutlet weak var noDateLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var calendarIcon: UIImageView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    // MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Set the color of the calendar icon
        calendarIcon.image = calendarIcon.image?.withRenderingMode(.alwaysTemplate)
        
        // Set the color of the text
        dateLabel.textColor = Colors.turquoise.color
        timeLabel.textColor = Colors.turquoise.color
        
        // Set the date if it already exists
        if ProfileManager.sharedInstance.isSurgerySet {
            self.setDate(date: ProfileManager.sharedInstance.getSurgeryDate())
            self.datePicker.setDate(ProfileManager.sharedInstance.getSurgeryDate(), animated: false)
        }
    }
    
    
    // MARK: - Helper functions
    private func setDate(date: Date) {
        // Update labels
        dateLabel.text = Util.getFormattedDate(date, dateStyle: .long, timeStyle: .none)
        timeLabel.text = Util.getFormattedDate(date, dateFormat: "EEEE, h:mm a")
        
        // Show date labels, hide default label
        dateLabel.isHidden = false
        timeLabel.isHidden = false
        noDateLabel.isHidden = true
        
        // Set the date in ProfileManager
        ProfileManager.sharedInstance.setSurgeryDate(date)
    }
    
    
    // MARK: - Date Picker
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        self.setDate(date: sender.date)
    }
}
