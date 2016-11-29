//
//  Theme.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/29/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit


enum Theme {
    case Default, SutterGreen, Blood
    
    var mainColor: UIColor {
        switch self {
        case .Default:
            return Colors.appleBlue.color
        case .SutterGreen:
            return Colors.turquoise.color
        case .Blood:
            return UIColor.red
        }
    }
}

struct ThemeManager {
    
    static func currentTheme() -> Theme {
        return .SutterGreen
    }
    
    static func applyTheme(theme: Theme) {
        let sharedApplication = UIApplication.shared
        sharedApplication.delegate?.window??.tintColor = theme.mainColor
        
        UIButton.appearance().tintColor = theme.mainColor
        //UIButton.appearance().back
    }
}
