//
//  Colors.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/10/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit


enum Colors {
    
    case turquoise, transTurquoise, realSutter, appleBlue, turquoiseLight1, turquoiseLight2, turquoiseLight3, healthRed
    
    var color: UIColor {
        switch self {
        case .turquoise:
            return UIColor(red: 0.0 / 255.0, green: 168.0 / 255.0, blue: 168.0 / 255.0, alpha: 1.0)
        
        case .turquoiseLight1:
            return UIColor(red: 0.0 / 255.0, green: 191.0 / 255.0, blue: 191.0 / 255.0, alpha: 1.0)
            
        case .turquoiseLight2:
            return UIColor(red: 0.0 / 255.0, green: 217.0 / 255.0, blue: 217.0 / 255.0, alpha: 1.0)
            
        case .turquoiseLight3:
            return UIColor(red: 0.0 / 255.0, green: 242.0 / 255.0, blue: 242.0 / 255.0, alpha: 1.0)
        
        case .transTurquoise:
            return UIColor(red: 0.0, green: 168.0 / 255.0, blue: 168.0 / 255.0, alpha: 0.1)
            
        case .realSutter:
            return UIColor(red: 89.0 / 255.0, green: 178.0 / 255.0, blue: 176.0 / 255.0, alpha: 1.0)
            
        case .appleBlue:
            return UIColor(red: 0.2, green: 0.451, blue: 0.99, alpha: 1)
            
        case .healthRed:
            return UIColor(red: 255.0 / 255.0, green: 71.0 / 255.0, blue: 71.0 / 255.0, alpha: 1)
        }
    }
}
