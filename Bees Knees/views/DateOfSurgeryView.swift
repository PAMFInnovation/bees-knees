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
