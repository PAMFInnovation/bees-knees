//
//  HorizontalRule.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/3/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit


class HorizontalRule: UIView {
    
    // MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(x: CGFloat, y:CGFloat, width: CGFloat) {
        self.init(frame: CGRect(x: x, y: y, width: width, height: 1))
        
        let gray: Float = 0.9
        self.backgroundColor = UIColor.init(colorLiteralRed: gray, green: gray, blue: gray, alpha: 1)
    }
}
