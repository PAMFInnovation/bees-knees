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
            notesTextArea.text = Copy.getWildernessGuideCopy(type: (appt?.type)!)
        }
    }
    
    var notesTextArea = UITextView()
    let notesHeight: CGFloat = 150
    
    
    // MARK: - Initialization
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // No selection style
        self.selectionStyle = .none
        
        // Set height values
        defaultHeight += notesHeight
        
        // Update the cell's height to match the needed height for the text area
        self.frame = CGRect(x: self.frame.minX, y: self.frame.minY, width: self.frame.width, height: self.frame.height + notesHeight)
        
        // Add the notes text area
        notesTextArea.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: notesHeight)
        notesTextArea.isEditable = false
        notesTextArea.isSelectable = false
        notesTextArea.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        notesTextArea.font = UIFont(name: "ArialMT", size: 16)
        notesTextArea.tintColor = UIColor.gray
        notesTextArea.textColor = UIColor.gray
        self.addSubview(notesTextArea)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Update the width of the views
        notesTextArea.frame = CGRect(x: notesTextArea.frame.minX, y: notesTextArea.frame.minY, width: self.frame.width, height: notesTextArea.frame.height)
    }
}
