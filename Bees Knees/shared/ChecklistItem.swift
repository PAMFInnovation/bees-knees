//
//  ChecklistItem.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 10/31/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit


protocol ChecklistItemDelegate: class {
    func doneEditing(sender: ChecklistItem)
}

class ChecklistItem: UITableViewCell, UITextFieldDelegate {
    
    var index: Int! = -1
    
    var toggleButton = UIButton()
    var itemField = UITextField()
    
    var delegate: ChecklistItemDelegate?
    
    
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
        toggleButton.setImage(disabled, for: .disabled)
        toggleButton.titleLabel?.text = ""
        toggleButton.addTarget(self, action: #selector(ChecklistItem.btnTouched), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Custom dimensions to fit any device
        let iconSize = self.frame.height * 0.5
        let heightOffset = (self.frame.height - iconSize) / 2
        let iconLeftOffset: CGFloat = 20.0
        let textOffset: CGFloat = 12.0
        let textWidth = self.frame.width - textOffset - iconSize - iconLeftOffset
        
        // Add the toggle image to the subview
        toggleButton.frame = CGRect(x: iconLeftOffset, y: heightOffset, width: iconSize, height: iconSize)
        self.addSubview(toggleButton)
        
        // Add the label to the subview
        itemField.frame = CGRect(x: iconSize + textOffset + iconLeftOffset, y: heightOffset, width: textWidth, height: iconSize)
        self.addSubview(itemField)
    }
    
    
    // MARK: - Helper functions
    func btnTouched() {
        if toggleButton.isEnabled {
            toggleButton.isSelected = !toggleButton.isSelected
            
            itemField.textColor = toggleButton.isSelected ? UIColor.lightGray : UIColor.black
        }
    }
    
    func enable() {
        toggleButton.isEnabled = true
    }
    
    func disable() {
        toggleButton.isEnabled = false
    }
    
    func saveText(textField: UITextField) {
        if !toggleButton.isEnabled && textField.text != "" {
            enable()
        }
        
        delegate?.doneEditing(sender: self)
    }
    
    
    // MARK: - Text Field Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveText(textField: textField)
        
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        saveText(textField: textField)
    }
}
