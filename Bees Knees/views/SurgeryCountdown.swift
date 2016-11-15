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
    
    var image: UIImage!
    var icon = UIImageView()
    var valueLabel = UILabel()
    var subtextLabel = UILabel()
    
    
    // MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Set the background color
        self.backgroundColor = Colors.turquoise.color
        
        // Set the icon
        image = UIImage(named: "clock-icon")
        image = image?.withRenderingMode(.alwaysTemplate)
        icon = UIImageView(image: image)
        icon.tintColor = UIColor.white
        
        // Set the value label
        valueLabel.textAlignment = .right
        valueLabel.font = UIFont(name: "Arial-BoldMT", size: 40)
        valueLabel.textColor = UIColor.white
        
        // Set the subtext label
        subtextLabel.textAlignment = .left
        subtextLabel.font = UIFont(name: "Arial-ItalicMT", size: 18)
        subtextLabel.textColor = UIColor.white
        
        // Update the labels
        updateSurgeryLabel()
        
        // Add the subviews
        self.addSubview(icon)
        self.addSubview(valueLabel)
        self.addSubview(subtextLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Position the labels proportionally to frame
        let xDivide = self.frame.width * 0.4
        let xPadding: CGFloat = 6
        
        icon.frame = CGRect(x: 10, y: 5, width: (image?.size.width)!, height: (image?.size.height)!)
        valueLabel.frame = CGRect(x: 0, y: 0, width: xDivide - xPadding, height: self.frame.height)
        subtextLabel.frame = CGRect(x: xDivide + xPadding, y: 0, width: self.frame.width - xDivide - xPadding, height: self.frame.height)
    }
    
    func updateSurgeryLabel() {
        // Get the days until surgery
        var days: Int = 0
        if ProfileManager.sharedInstance.isSurgerySet {
            let calendar = Calendar.current
            
            // Replace the hour (time) of surgery date and current date with 00:00
            let date1 = calendar.startOfDay(for: Date())
            let date2 = calendar.startOfDay(for: ProfileManager.sharedInstance.getSurgeryDate())
            
            let flags: Set<Calendar.Component> = [Calendar.Component.day]
            let components = calendar.dateComponents(flags, from: date1, to: date2)
            
            // Set the number of days between dates
            days = components.day!
        }
        
        // Update labels
        subtextLabel.text = days < 0 ? "days since surgery" : "days until surgery"
        valueLabel.text = abs(days).description
    }
}
