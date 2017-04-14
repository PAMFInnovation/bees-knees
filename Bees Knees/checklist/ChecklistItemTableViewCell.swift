//
//  ChecklistItemTableViewCell.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 10/31/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit

protocol ChecklistItemTableViewCellDelegate: class {
    func beginEditing(element: UITextView)
    func doneEditing(sender: ChecklistItemTableViewCell, item: ChecklistItem)
    func toggleCompleted(sender: ChecklistItemTableViewCell, item: ChecklistItem)
}

class ChecklistItemTableViewCell: UITableViewCell, UITextViewDelegate {
    
    var checklistItem: ChecklistItem?
    
    var toggleButton = UIButton()
    var addButton = UIButton()
    var itemField = UITextView()
    
    var delegate: ChecklistItemTableViewCellDelegate?
    
    // MARK: - Initialization
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        // No selection style
        self.selectionStyle = .none
        
        // Set text field attributes
        self.itemField.returnKeyType = .done
        self.itemField.delegate = self
        self.itemField.isScrollEnabled = false
        self.itemField.font = .systemFont(ofSize: 16)
        
        // Create the toggle image
        let normal: UIImage = UIImage(named: "checkbox")!
        let selected: UIImage = UIImage(named: "checkbox-filled")!
        let disabled: UIImage = UIImage(named: "add")!
        
        self.toggleButton = UIButton(type: .custom)
        self.toggleButton.setImage(normal, for: .normal)
        self.toggleButton.setImage(selected, for: .selected)
        self.toggleButton.titleLabel?.text = ""
        self.toggleButton.addTarget(self, action: #selector(ChecklistItemTableViewCell.btnTouched), for: .touchUpInside)
        
        // Create the add button image
        self.addButton = UIButton(type: .custom)
        self.addButton.setImage(disabled, for: .normal)
        self.addButton.titleLabel?.text = ""
        self.addButton.addTarget(self, action: #selector(ChecklistItemTableViewCell.addButtonTouched), for: .touchUpInside)
        
        self.addSubview(toggleButton)
        self.addSubview(itemField)
        self.addSubview(addButton)
        self.itemField.translatesAutoresizingMaskIntoConstraints = false;
        self.toggleButton.translatesAutoresizingMaskIntoConstraints = false;
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addButton.frame = CGRect(x: 20, y: 3, width: 30, height: 31)
        
        let customLabelTopConstraint = NSLayoutConstraint(item: self.itemField, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 3)
        
        let customLabelBottomConstraint = NSLayoutConstraint(item: self.itemField, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal
            , toItem: self, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: -3)
        
        let customLabelLeadingConstraint = NSLayoutConstraint(item: self.itemField, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal
            , toItem: self, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 60)
        
        let customLabelTrailingConstraint = NSLayoutConstraint(item: self.itemField, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal
            , toItem: self, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: -50)
        
        NSLayoutConstraint.activate([customLabelTopConstraint, customLabelBottomConstraint, customLabelLeadingConstraint, customLabelTrailingConstraint])
        
        let toggleButtonTopConstraint = NSLayoutConstraint(item: self.toggleButton, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 3)
        
        let toggleButtonBottomConstraint = NSLayoutConstraint(item: self.toggleButton, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal
            , toItem: self, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: -3)
        
        let toggleButtonLeadingConstraint = NSLayoutConstraint(item: self.toggleButton, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal
            , toItem: self, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 20)
        
        NSLayoutConstraint.activate([toggleButtonTopConstraint, toggleButtonBottomConstraint, toggleButtonLeadingConstraint])
    
    }
    
    // MARK: - Helper functions
    func setChecklistItem(item: ChecklistItem) {
        self.checklistItem = item
        
        // Toggle the button if it is completed
        self.setChecked((self.checklistItem?.completed)!)
    }
    
    func btnTouched() {
        delegate?.toggleCompleted(sender: self, item: checklistItem!)
    }
    
    func addButtonTouched() {
        itemField.becomeFirstResponder()
    }
    
    func setChecked(_ state: Bool) {
        // Toggle the button if it is completed
        toggleButton.isSelected = state
        itemField.textColor = toggleButton.isSelected ? UIColor.lightGray : UIColor.black
    }
    
    func enable() {
        try! ProfileManager.sharedInstance.realm.write {
            checklistItem?.enabled = true
        }
        toggleButton.isHidden = false
        addButton.isHidden = true
    }
    
    func disable() {
        try! ProfileManager.sharedInstance.realm.write {
            checklistItem?.enabled = false
        }
        toggleButton.isHidden = true
        addButton.isHidden = false
    }
    
    func saveText(textField: UITextView) {
        if !(checklistItem?.enabled)! && textField.text != "" {
            enable()
        }
        
        if delegate != nil && checklistItem != nil {
            delegate?.doneEditing(sender: self, item: checklistItem!)
        }
    }
    
    // MARK: - Text View Delegate
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        saveText(textField: textView)
        //textView.resignFirstResponder()
        return true
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        delegate?.beginEditing(element: textView)
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        saveText(textField: textView)
       // textView.resignFirstResponder()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text.compare("\n").rawValue == 0) {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
   
    
}
