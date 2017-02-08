//
//  Date+DayOfWeek.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 2/6/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import Foundation


extension Date {
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
}
