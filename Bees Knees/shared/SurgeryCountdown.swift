//
//  SurgeryCountdown.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/1/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import Foundation
import UIKit


protocol SurgeryCountdownDelegate: class {
    func tapEditSurgeryDate(sender: SurgeryCountdown)
    //func transitionToPostSurgery(sender: SurgeryCountdown)
}

class SurgeryCountdown: UIView {
    
    var image: UIImage!
    var icon = UIImageView()
    var valueLabel = UILabel()
    var subtextLabel = UILabel()
    var notSetLabel = UILabel()
    
    var delegate: SurgeryCountdownDelegate?
    
    var manuallyTransitionToPostSurgery: Bool = false
    var manuallyTransitionToPreSurgery: Bool = false
    
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
        
        // Set the "Surgery Not Set" label
        notSetLabel.textAlignment = .left
        notSetLabel.font = UIFont(name: "Arial-ItalicMT", size: 16)
        notSetLabel.textColor = UIColor.white
        notSetLabel.numberOfLines = 0
        notSetLabel.lineBreakMode = .byWordWrapping
        
        // Add a tap listener on the view
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(SurgeryCountdown.tap))
        self.addGestureRecognizer(tap)
        
        // Update the labels
        updateSurgeryLabel()
        
        // Add the subviews
        self.addSubview(icon)
        self.addSubview(valueLabel)
        self.addSubview(subtextLabel)
        self.addSubview(notSetLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Position the labels proportionally to frame
        let xDivide = self.frame.width * 0.4
        let xPadding: CGFloat = 6
        let notSetX: CGFloat = 10 + (image?.size.width)!
        
        icon.frame = CGRect(x: 10, y: 5, width: (image?.size.width)!, height: (image?.size.height)!)
        valueLabel.frame = CGRect(x: 0, y: 0, width: xDivide - xPadding, height: self.frame.height)
        subtextLabel.frame = CGRect(x: xDivide + xPadding, y: 0, width: self.frame.width - xDivide - xPadding, height: self.frame.height)
        notSetLabel.frame = CGRect(x: notSetX, y: 0, width: self.frame.width - notSetX, height: self.frame.height)
    }
    
    func updateSurgeryLabel() {
        // Get the days until surgery
        var days: Int = 0
        if ProfileManager.sharedInstance.isSurgerySet() {
            let calendar = Calendar.current
            
            // Replace the hour (time) of surgery date and current date with 00:00
            let date1 = calendar.startOfDay(for: Date())
            let date2 = calendar.startOfDay(for: ProfileManager.sharedInstance.getSurgeryDate())
            
            let flags: Set<Calendar.Component> = [Calendar.Component.day]
            let components = calendar.dateComponents(flags, from: date1, to: date2)
            
            // Set the number of days between dates
            days = components.day!
            
            // Check if the patient has already had surgery and in the Pre-Surgery routine
            // Here we'll prompt them to visit Post-Surgery
            if days < 0 && ProfileManager.sharedInstance.user.flowState == .PreSurgeryRoutine {
                subtextLabel.text = ""
                valueLabel.text = ""
                notSetLabel.text = "Already had surgery? Tap to change or transition to your Post-Surgery routine"
                manuallyTransitionToPostSurgery = true
            }
            else if days > 0 && ProfileManager.sharedInstance.user.flowState == .PostSurgeryRoutine {
                subtextLabel.text = ""
                valueLabel.text = ""
                notSetLabel.text = "Haven't had your surgery yet? Tap to transition to your pre-surgery routine."
                manuallyTransitionToPostSurgery = false
                manuallyTransitionToPreSurgery = true
            }
            // Else display the counter normally
            else {
                subtextLabel.text = days < 0 ? "days since surgery" : "days until surgery"
                valueLabel.text = abs(days).description
                notSetLabel.text = ""
                manuallyTransitionToPostSurgery = false
                manuallyTransitionToPreSurgery = false
            }
        }
        else {
            subtextLabel.text = ""
            valueLabel.text = ""
            notSetLabel.text = "Tap to enter your surgery date and start your roadmap"
            manuallyTransitionToPostSurgery = false
        }
    }
    
    func tap(tap: UITapGestureRecognizer) {
        // Check for tap within the view's rect
        if tap.state == .ended {
            let point = tap.location(in: self)
            if self.frame.contains(point) {
                // Trigger the delegate function if it's set
                if delegate != nil {
                    if manuallyTransitionToPostSurgery == true {
                        //delegate?.transitionToPostSurgery(sender: self)
                        (self.window!.rootViewController as! RootViewController).transitionToPostSurgeryWelcomeFlow()
                    } else if manuallyTransitionToPreSurgery == true {
                        //delegate?.transitionToPostSurgery(sender: self)
                        (self.window!.rootViewController as! RootViewController).transitionToPreSurgeryWelcomeFlow()
                    }
                    else {
                        delegate?.tapEditSurgeryDate(sender: self)
                    }
                }
            }
        }
    }
}
