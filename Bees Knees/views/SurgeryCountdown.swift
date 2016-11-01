//
//  SurgeryCountdown.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/1/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import Foundation
import UIKit


class SurgeryCountdown: UIView {
    
    var valueLabel = UILabel()
    var subtextLabel = UILabel()
    
    
    // MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Set the background color
        self.backgroundColor = UIColor.lightGray
        
        // Get the days until surgery
        var days: String = "??"
        if (ProfileManager.sharedInstance.surgeryDate != nil) {
            let calendar = Calendar.current
            
            // Replace the hour (time) of surgery date and current date with 00:00
            let date1 = calendar.startOfDay(for: Date())
            let date2 = calendar.startOfDay(for: ProfileManager.sharedInstance.surgeryDate!)
            
            let flags: Set<Calendar.Component> = [Calendar.Component.day]
            let components = calendar.dateComponents(flags, from: date1, to: date2)
            
            // Set the number of days between dates
            days = (components.day?.description)!
        }
        
        
        // Set the value label
        valueLabel.text = days
        valueLabel.textAlignment = .right
        valueLabel.font = UIFont(name: "Arial-BoldMT", size: 40)
        
        // Set the subtext label
        subtextLabel.text = "days until surgery"
        subtextLabel.textAlignment = .left
        subtextLabel.font = UIFont(name: "Arial-ItalicMT", size: 18)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Position the labels proportionally to frame
        let xDivide = self.frame.width * 0.4
        let xPadding: CGFloat = 6
        
        valueLabel.frame = CGRect(x: 0, y: 0, width: xDivide - xPadding, height: self.frame.height)
        subtextLabel.frame = CGRect(x: xDivide + xPadding, y: 0, width: self.frame.width - xDivide - xPadding, height: self.frame.height)
        
        self.addSubview(valueLabel)
        self.addSubview(subtextLabel)
    }
}
