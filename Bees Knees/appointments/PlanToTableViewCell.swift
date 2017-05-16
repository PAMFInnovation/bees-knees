//
//  TextTableViewCell.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 1/10/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import UIKit


class PlanToTableViewCell: AppointmentTableViewCell {
    
    override var appointment: Appointment? {
        willSet(appt) {
            planToTextArea.text = ProfileManager.sharedInstance.getPlanTo(appointmentType: (appt?.type.description)!)

            let fixedWidth = planToTextArea.frame.size.width
            planToTextArea.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            let newSize = planToTextArea.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            var newFrame = planToTextArea.frame
            newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
            planToTextArea.frame = newFrame;
            
            print("height", planToTextArea.contentSize.height)
            self.expandedHeight = planToTextArea.contentSize.height
        }
    }
    
    var planToTextArea = UITextView()
    var height: CGFloat = 100
    
    // MARK: - Initialization
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // No selection style
        self.selectionStyle = .none
        
        // Set height values
        defaultHeight += height
        
        // Update the cell's height to match the needed height for the text area
        self.frame = CGRect(x: self.frame.minX, y: self.frame.minY, width: self.frame.width, height: self.frame.height + self.height)
        
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
     //   self.expandedHeight = self.planToTextArea.layoutManager.usedRect(for: self.planToTextArea.textContainer).size.height
     //   self.height = self.expandedHeight;
        // Update the height of the views
     //   planToTextArea.frame = CGRect(x: planToTextArea.frame.minX, y: planToTextArea.frame.minY, width: self.frame.width, height: self.height)

    }
}
