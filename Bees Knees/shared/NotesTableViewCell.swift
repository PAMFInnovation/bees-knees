//
//  NotesTableViewCell.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/3/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit


class NotesTableViewCell: AppointmentTableViewCell, UITextViewDelegate {
    
    override var appointment: Appointment? {
        willSet(appt) {
            notesTextArea.text = appt?.notes
            
            // Show or hide the placeholder label
            placeholderLabel.isHidden = notesTextArea.text == "" ? false : true
        }
    }
    
    var notesTextArea = UITextView()
    var placeholderLabel = UILabel()
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
        notesTextArea.isEditable = true
        notesTextArea.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        notesTextArea.delegate = self
        notesTextArea.font = UIFont(name: "ArialMT", size: 16)
        notesTextArea.tintColor = UIColor.gray
        notesTextArea.textColor = UIColor.gray
        self.addSubview(notesTextArea)
        
        // Add the placeholder label
        placeholderLabel.frame = CGRect(x: 15, y: 0, width: self.frame.width, height: 40)
        placeholderLabel.text = "Tap here to edit notes..."
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.font = UIFont(name: "Arial-ItalicMT", size: 16)
        self.addSubview(placeholderLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Update the width of the views
        notesTextArea.frame = CGRect(x: notesTextArea.frame.minX, y: notesTextArea.frame.minY, width: self.frame.width, height: notesTextArea.frame.height)
        placeholderLabel.frame = CGRect(x: placeholderLabel.frame.minX, y: placeholderLabel.frame.minY, width: self.frame.width, height: placeholderLabel.frame.height)
    }
    
    
    // MARK: - Text View Delegate
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        delegate?.beginEditing(sender: textView)
        
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        appointment?.updateNotes(notes: textView.text)
        
        // Show or hide the placeholder label
        placeholderLabel.isHidden = notesTextArea.text == "" ? false : true
    }
}
