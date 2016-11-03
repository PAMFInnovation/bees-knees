//
//  AppointmentCellData.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/3/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit


class AppointmentCellData: NSObject {
    
    var name: String = ""
    var defaultHeight: CGFloat = 44
    
    
    init(name: String) {
        self.name = name
    }
}
