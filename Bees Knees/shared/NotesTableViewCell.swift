//
//  NotesTableViewCell.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/3/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit


class NotesTableViewCell: AppointmentTableViewCell, UITextViewDelegate {
    
    var hRule: HorizontalRule!
    var notesTextArea = UITextView()
    let notesHeight: CGFloat = 150
    
    
    // MARK: - Initialization
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // No selection style
        self.selectionStyle = .none
        
        // Set label text
        self.label.text = "Notes"
        
        // Set height values
        defaultHeight += notesHeight
        
        // Update the cell's height to match the needed height for the text area
        self.frame = CGRect(x: self.frame.minX, y: self.frame.minY, width: self.frame.width, height: self.frame.height + notesHeight)
        
        // Add a horizontal rule
        hRule = HorizontalRule(x: 15, y: label.frame.height, width: self.frame.width)
        self.addSubview(hRule)
        
        // Add the notes text area
        notesTextArea.frame = CGRect(x: 0, y: label.frame.height + 1, width: self.frame.width, height: notesHeight)
        notesTextArea.isEditable = true
        notesTextArea.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        notesTextArea.delegate = self
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
        hRule.frame = CGRect(x: hRule.frame.minX, y: hRule.frame.minY, width: self.frame.width, height: hRule.frame.height)
        notesTextArea.frame = CGRect(x: notesTextArea.frame.minX, y: notesTextArea.frame.minY, width: self.frame.width, height: notesTextArea.frame.height)
    }
    
    
    // MARK: - Text View Delegate
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        delegate?.beginEditing(sender: textView)
        
        return true
    }
}
