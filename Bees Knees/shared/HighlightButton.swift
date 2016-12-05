//
//  HighlightButton.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 10/26/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit


class HighlightButton: UIButton {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? Colors.turquoise.color : UIColor.white
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            borderColor = isEnabled ? Colors.turquoise.color : UIColor.lightGray
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
    
    
    func customize() {
        // Make this button a rounded rect
        self.borderWidth = 1
        self.borderColor = Colors.turquoise.color
        self.cornerRadius = 5
        
        // Set initial color, overriding what is set in the builder
        up()
        
        // Set additional color states
        self.setTitleColor(Colors.turquoise.color, for: .normal)
        self.setTitleColor(UIColor.white, for: .highlighted)
        self.setTitleColor(UIColor.lightGray, for: .disabled)
        
        // Set font size
        self.titleLabel?.font = UIFont(name: "ArialMT", size: 16)
        
        // Add selectors for button up and down
        self.addTarget(self, action: #selector(HighlightButton.down), for: .touchDown)
        self.addTarget(self, action: #selector(HighlightButton.up), for: .touchUpInside)
        self.addTarget(self, action: #selector(HighlightButton.up), for: .touchUpOutside)
    }
    
    
    func down() {
        //self.backgroundColor = Colors.appleBlue.color
    }
    
    func up() {
        //self.backgroundColor = UIColor.white
    }
}
