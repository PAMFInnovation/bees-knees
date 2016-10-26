//
//  HighlightButton.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 10/26/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit


class HighlightButton: UIButton {
    
    var downColor: UIColor = UIColor(red: 0.69, green: 0.82, blue: 0.98, alpha: 1.0)
    var upColor: UIColor = UIColor(red: 0.23, green: 0.54, blue: 0.94, alpha: 1.0)
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Set initial color, overriding what is set in the builder
        up()
        
        // Add selectors for button up and down
        self.addTarget(self, action: #selector(HighlightButton.down), for: .touchDown)
        self.addTarget(self, action: #selector(HighlightButton.up), for: .touchUpInside)
        self.addTarget(self, action: #selector(HighlightButton.up), for: .touchUpOutside)
    }
    
    
    func down() {
        self.backgroundColor = downColor
    }
    
    func up() {
        self.backgroundColor = upColor
    }
}
