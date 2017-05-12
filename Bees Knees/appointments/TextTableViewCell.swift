//
//  TextTableViewCell.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 1/10/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import UIKit


class TextTableViewCell: AppointmentTableViewCell {
    
    override var appointment: Appointment? {
        willSet(appt) {
            planToTextArea.text = ProfileManager.sharedInstance.getPlanTo(appointmentType: (appt?.type.description)!)
            //Copy.getWildernessGuideCopy(type: (appt?.type)!)
        }
    }
    
    var planToTextArea = UITextView()
    let height: CGFloat = 350
    
    
    // MARK: - Initialization
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // No selection style
        self.selectionStyle = .none
        
        // Set height values
        defaultHeight += height
        
        // Update the cell's height to match the needed height for the text area
        self.frame = CGRect(x: self.frame.minX, y: self.frame.minY, width: self.frame.width, height: self.frame.height + height)
        
        // Add the notes text area
        planToTextArea.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: height)
        planToTextArea.isEditable = false
        planToTextArea.isSelectable = false
        planToTextArea.isScrollEnabled = false
        planToTextArea.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        planToTextArea.font = UIFont(name: "ArialMT", size: 16)
        planToTextArea.tintColor = UIColor.gray
        planToTextArea.textColor = UIColor.gray
        self.addSubview(planToTextArea)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Update the width of the views
        planToTextArea.frame = CGRect(x: planToTextArea.frame.minX, y: planToTextArea.frame.minY, width: self.frame.width, height: planToTextArea.frame.height)
    }
}
