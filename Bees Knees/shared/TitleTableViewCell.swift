//
//  TitleTableViewCell.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/3/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit


class TitleTableViewCell: AppointmentTableViewCell, UITextFieldDelegate {
    
    var titleField = UITextField()
    
    
    // MARK: - Initialization
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // No selection style
        self.selectionStyle = .none
        
        // Set text field attributes
        titleField.returnKeyType = .done
        titleField.delegate = self
        
        // Set label text
        labelText = "Title"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Add the title text field
        titleField.frame = CGRect(x: self.label.frame.maxX, y: 0, width: self.frame.width - self.label.frame.maxX, height: self.frame.height)
        titleField.tintColor = UIColor.gray
        titleField.textColor = UIColor.gray
        self.addSubview(titleField)
    }
    
    
    // MARK: - Text Field Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
