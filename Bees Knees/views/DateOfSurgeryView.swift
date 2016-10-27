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
    
    
    // MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    // MARK: - Helper functions
    private func setDate(date: Date) {
        // Format the date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.long
        dateFormatter.timeStyle = DateFormatter.Style.none
        let dateString = dateFormatter.string(from: date)
        
        // Format te time
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "EEEE, h:mm a"
        let timeString = timeFormatter.string(from: date)
        
        // Update labels
        dateLabel.text = dateString
        timeLabel.text = timeString
        
        // Show date labels, hide default label
        dateLabel.isHidden = false
        timeLabel.isHidden = false
        noDateLabel.isHidden = true
        
        // Set the date in ProfileManager
        ProfileManager.sharedInstance.surgeryDate = date
    }
    
    
    // MARK: - Date Picker
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        self.setDate(date: sender.date)
    }
}
