//
//  CustomButton.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 1/28/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import UIKit


class CustomButton: UIButton {
    
    var primaryColor: UIColor = Colors.turquoise.color
    var secondaryColor: UIColor = UIColor.white
    var disabledColor: UIColor = UIColor.lightGray
    var textDownColor: UIColor = Colors.turquoise.color
    
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? primaryColor : secondaryColor
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            borderColor = isEnabled ? primaryColor : disabledColor
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        customize()
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        
        customize()
    }
    
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 160, height: 42))
    }
    
    convenience init(primaryColor: UIColor, secondaryColor: UIColor, disabledColor: UIColor, textDownColor: UIColor) {
        self.init()
        
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
        self.disabledColor = disabledColor
        self.textDownColor = textDownColor
        
        customize()
    }
    
    convenience init(frame: CGRect, primaryColor: UIColor, secondaryColor: UIColor, disabledColor: UIColor, textDownColor: UIColor) {
        self.init(frame: frame)
        
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
        self.disabledColor = disabledColor
        self.textDownColor = textDownColor
        
        customize()
    }
    
    
    func customize() {
        // Make this button a rounded rect
        self.borderWidth = 1
        self.borderColor = primaryColor
        self.cornerRadius = 5
        
        // Set additional color states
        self.setTitleColor(primaryColor, for: .normal)
        self.setTitleColor(textDownColor, for: .highlighted)
        self.setTitleColor(disabledColor, for: .disabled)
        
        // Set initial background color
        self.backgroundColor = secondaryColor
        
        // Set font size
        self.titleLabel?.font = UIFont(name: "ArialMT", size: 16)
    }
}
