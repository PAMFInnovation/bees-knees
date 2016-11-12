//
//  Util.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/10/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import Foundation


class Util {
    
    static func getFormattedDate(_ date: Date, dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let dateString = dateFormatter.string(from: date)
        
        return dateString
    }
    
    static func getFormattedDate(_ date: Date, dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = dateStyle
        dateFormatter.timeStyle = timeStyle
        let dateString = dateFormatter.string(from: date)
        
        return dateString
    }
    
    static func getDateFromString(_ string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let date = dateFormatter.date(from: string)
        return date!
    }
    
    static func isDateInPast(_ date: Date) -> Bool {
        let today: NSDate = NSDate()
        
        if today as Date > date {
            return true
        }
        return false
    }
}
