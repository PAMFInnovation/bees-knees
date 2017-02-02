//
//  ChecklistItemTableViewCell.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 10/31/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit


protocol ChecklistItemTableViewCellDelegate: class {
    func beginEditing(element: UIControl)
    func doneEditing(sender: ChecklistItemTableViewCell, item: ChecklistItem)
    func toggleCompleted(sender: ChecklistItemTableViewCell, item: ChecklistItem)
}

class ChecklistItemTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    var checklistItem: ChecklistItem?
    
    var toggleButton = UIButton()
    var addButton = UIButton()
    var itemField = UITextField()
    
    var delegate: ChecklistItemTableViewCellDelegate?
    
    
    // MARK: - Initialization
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        // No selection style
        self.selectionStyle = .none
        
        // Set text field attributes
        itemField.returnKeyType = .done
        itemField.delegate = self
        
        // Create the toggle image
        let normal: UIImage = UIImage(named: "checkbox")!
        let selected: UIImage = UIImage(named: "checkbox-filled")!
        let disabled: UIImage = UIImage(named: "add")!
        toggleButton = UIButton(type: .custom)
        toggleButton.setImage(normal, for: .normal)
        toggleButton.setImage(selected, for: .selected)
        toggleButton.titleLabel?.text = ""
        toggleButton.addTarget(self, action: #selector(ChecklistItemTableViewCell.btnTouched), for: .touchUpInside)
        
        // Create the add button image
        addButton = UIButton(type: .custom)
        addButton.setImage(disabled, for: .normal)
        addButton.titleLabel?.text = ""
        addButton.addTarget(self, action: #selector(ChecklistItemTableViewCell.addButtonTouched), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Custom dimensions to fit any device
        let iconSize = self.frame.height * 0.5
        let heightOffset = (self.frame.height - iconSize) / 2
        let iconLeftOffset: CGFloat = 20.0
        let textOffset: CGFloat = 12.0
        let textWidth = self.frame.width - textOffset - iconSize - iconLeftOffset
        
        // Add the toggle button to the subview
        toggleButton.frame = CGRect(x: iconLeftOffset, y: heightOffset, width: iconSize, height: iconSize)
        self.addSubview(toggleButton)
        
        // Add the add button to the subview in the same place as the toggle
        addButton.frame = CGRect(x: iconLeftOffset, y: heightOffset, width: iconSize, height: iconSize)
        self.addSubview(addButton)
        
        // Add the label to the subview
        itemField.frame = CGRect(x: iconSize + textOffset + iconLeftOffset, y: heightOffset, width: textWidth, height: iconSize)
        self.addSubview(itemField)
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
    
    func saveText(textField: UITextField) {
        if !(checklistItem?.enabled)! && textField.text != "" {
            enable()
        }
        
        if delegate != nil && checklistItem != nil {
            delegate?.doneEditing(sender: self, item: checklistItem!)
        }
    }
    
    
    // MARK: - Text Field Delegate
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        delegate?.beginEditing(element: textField)
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveText(textField: textField)
        
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        saveText(textField: textField)
    }
}
