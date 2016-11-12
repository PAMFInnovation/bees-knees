//
//  Colors.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/10/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit


enum Colors {
    
    case turquoise
    
    var color: UIColor {
        switch self {
        case .turquoise:
            return UIColor(red: 0.0, green: 168.0 / 255.0, blue: 168.0 / 255.0, alpha: 1.0)
        }
    }
}
