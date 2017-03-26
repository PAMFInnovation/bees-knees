//
//  Util.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/10/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import Foundation
import ResearchKit
import Gloss


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
    
    static func getDateFromString(_ string: String, format: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
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
    
    static func getURLForResource(resource: String, type: String) -> NSURL {
        guard let path = Bundle.main.path(forResource: resource, ofType: type) else {
            print("Resource not found!")
            return NSURL()
        }
        
        let url: NSURL = NSURL(fileURLWithPath: path)
        return url
    }
    
    static func getJSONForResource<T:GlossModel>(resource: String) -> T {
        if let path = Bundle.main.path(forResource: resource, ofType: "json") {
            do {
                print(path)
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                print(data)
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                print(json)
                return T(json: json as! JSON)
            }
            catch let error {
                print("getJSONForResource error", error.localizedDescription)
            }
        }
        else {
            print("Invalid filename/path.")
        }
        return T(json: JSON())
    }
    
    static func isSimulator() -> Bool {
        // Ignore passcode on simulator as it'll cause errors
        var isSimulator = false
        #if (arch(i386) || arch(x86_64)) && (os(iOS) || os(watchOS) || os(tvOS))
            isSimulator = true
        #endif
        return isSimulator
    }
    
    static func isPasscodeSet() -> Bool {
        return ORKPasscodeViewController.isPasscodeStoredInKeychain()
    }
}
