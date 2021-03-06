//
//  NotesTableViewCell.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/3/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit

//TODO: Commented the code that was written to customize notes text area to expand to the size of text when user is viewing it. Need to work on edit mode if needed.

class NotesTableViewCell: AppointmentTableViewCell, UITextViewDelegate {
    
    override var appointment: Appointment? {
        willSet(appt) {
            notesTextArea.text = appt?.notes
            
            // Show or hide the placeholder label
            placeholderLabel.isHidden = notesTextArea.text == "" ? false : true
            
//            
//            let fixedWidth = notesTextArea.frame.size.width
//            notesTextArea.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
//            let newSize = notesTextArea.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
//            var newFrame = notesTextArea.frame
//            newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
//            notesTextArea.frame = newFrame;
//            
//            print("height", notesTextArea.contentSize.height)
//            // If cell height is less than 150 based on the text, then set it to 150 to allow users to type more text.
//            if( notesTextArea.contentSize.height > 200) {
//                self.expandedHeight = notesTextArea.contentSize.height
//            } else {
//                self.expandedHeight = 200
//            }
        }
    }
    
    var notesTextArea = UITextView()
    var placeholderLabel = UILabel()
    let notesHeight: CGFloat = 150
    
    // When the user begins editing notes, a done button will appear in the
    // top-right and potentially overwrite an existing button. We will keep
    // track of that button here to display when the user is done editing notes.
    var rightBarButtonItemUnderneath: UIBarButtonItem?
    
    
    // MARK: - Initialization
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // No selection style
        self.selectionStyle = .none
        
        // Set height values
        defaultHeight += notesHeight
      //  self.expandedHeight = notesHeight
        
        // Update the cell's height to match the needed height for the text area
        self.frame = CGRect(x: self.frame.minX, y: self.frame.minY, width: self.frame.width, height: self.frame.height + notesHeight)
        
        // Add the notes text area
        notesTextArea.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: notesHeight)
        notesTextArea.isEditable = true
      //  notesTextArea.scrollsToTop = true
      //  notesTextArea.isScrollEnabled = false
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
    
    
    // MARK: - Helper functions
    func doneEditing() {
        self.endEditing(true)
        
        // Reset the right bar button item
        self.parentViewController?.navigationItem.rightBarButtonItem = rightBarButtonItemUnderneath
        
//        self.notesTextArea.scrollsToTop = true
//        self.notesTextArea.isScrollEnabled = false
//        // update notes text area
//        let fixedWidth = notesTextArea.frame.size.width
//        notesTextArea.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
//        let newSize = notesTextArea.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
//        var newFrame = notesTextArea.frame
//        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
//        notesTextArea.frame = newFrame;
//        
//        self.layoutSubviews()
    }
    
    
    // MARK: - Text View Delegate
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        delegate?.beginEditing(sender: textView)
        
       // notesTextArea.scrollsToTop = false
       // notesTextArea.isScrollEnabled = true
        
        // Add the done button in the navigation bar
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(NotesTableViewCell.doneEditing))
        rightBarButtonItemUnderneath = self.parentViewController?.navigationItem.rightBarButtonItem
        self.parentViewController?.navigationItem.rightBarButtonItem = doneButton
        
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        appointment?.updateNotes(notes: textView.text)
        
        // Show or hide the placeholder label
        placeholderLabel.isHidden = notesTextArea.text == "" ? false : true
    }
}
