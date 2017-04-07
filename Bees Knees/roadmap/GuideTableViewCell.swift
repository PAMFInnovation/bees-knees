//
//  GuideTableViewCell.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/10/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit


class GuideTableViewCell: UITableViewCell {
    
    // Reference to the appointment
    var appointment: Appointment?
    
    // Custom views
    var icon: UIImageView = UIImageView()
    var title: UILabel = UILabel()
    var subtitle: UILabel = UILabel()
    var detail: UITextView = UITextView()
    var nextApptLabel: UILabel = UILabel()
    var dateText: UITextView = UITextView()
    
    // Fonts
    let titleNormalFont = UIFont(name: "ArialMT", size: 16)
    let subtitleNormalFont = UIFont(name: "ArialMT", size: 12)
    let titleItalicFont = UIFont(name: "Arial-ItalicMT", size: 16)
    let subtitleItalicFont = UIFont(name: "Arial-ItalicMT", size: 12)
    let subtitleBoldFont = UIFont(name: "Arial-BoldMT", size: 12)
    
    // Info icon
    let infoIcon: UIImage = UIImage(named: "info-icon")!
    
    
    // MARK: - Initialization
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
        
        // Set a custom background view with transparency
        let bgColorView = UIView()
        bgColorView.backgroundColor = Colors.transTurquoise.color
        self.selectedBackgroundView = bgColorView
        
        // Set content clipping
        self.autoresizingMask = .flexibleHeight
        self.clipsToBounds = true
        
        // Set icon as non-interactive
        self.icon.isUserInteractionEnabled = false
        
        // Customize labels
        self.title.font = titleNormalFont
        self.subtitle.font = subtitleNormalFont
        
        // Customize the detail text view
        self.detail.font = subtitleNormalFont
        self.detail.isEditable = false
        self.detail.isSelectable = false
        self.detail.backgroundColor = UIColor.clear
        self.detail.contentInset = UIEdgeInsets.zero
        self.detail.isUserInteractionEnabled = false
        
        // Set next appointment label
        self.nextApptLabel.text = "NEXT APPOINTMENT"
        self.nextApptLabel.font = UIFont(name: "Arial-BoldMT", size: 10)
        self.nextApptLabel.textColor = UIColor.white
        self.nextApptLabel.textAlignment = .center
        self.nextApptLabel.backgroundColor = Colors.turquoiseLight1.color
        
        // Setup the date text view
        self.dateText.text = ""
        self.dateText.font = subtitleNormalFont
        self.dateText.isEditable = false
        self.dateText.isSelectable = false
        self.dateText.textAlignment = .center
        self.dateText.textColor = UIColor.lightGray
        self.dateText.isUserInteractionEnabled = false
        
        
        // Add custom subviews
        self.addSubview(title)
        self.addSubview(subtitle)
        self.addSubview(detail)
        self.addSubview(dateText)
        self.addSubview(nextApptLabel)
        self.addSubview(icon)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    // MARK: - Helper functions
    func setAppointment(appointment: Appointment, isNextAppointment: Bool) {
        self.appointment = appointment
        
        // Frame sizing variables
        let size: CGPoint = CGPoint(x: 70.0, y: 70.0)
        let gap: CGFloat = 10.0
        let xOffset: CGFloat = 8.0
        let yOffset: CGFloat = 0.0
        let textWidth = self.frame.width - xOffset - size.x - gap - 20
        
        // Appointments that are already scheduled should display normal information
        if appointment.scheduled == true {
            // Change UI if the date is in the past
            let inPast: Bool = (self.appointment?.elapsed)!
            
            // Set text
            self.title.text = self.appointment?.title
            self.subtitle.text = Util.getFormattedDate((self.appointment?.date)!, dateFormat: "EEE, MMM d yyyy - h:mma")
            self.detail.text = isNextAppointment ? ProfileManager.sharedInstance.getPlanTo(appointmentType: appointment.type.description): ""
            //isNextAppointment ? Copy.getWildernessGuideCopy(type: appointment.type) : ""
            self.dateText.text = Util.getFormattedDate((self.appointment?.date)!, dateFormat: "MMM d\nh:mm a")
            
            // For dates that have passed, italicize the text
            if inPast {
                self.title.font = titleNormalFont
                self.title.textColor = UIColor.lightGray
                self.subtitle.font = subtitleNormalFont
                self.subtitle.textColor = UIColor.lightGray
                self.dateText.font = subtitleItalicFont
                self.dateText.textColor = UIColor.lightGray
            }
            else {
                self.title.font = titleNormalFont
                self.title.textColor = UIColor.black
                self.subtitle.font = subtitleNormalFont
                self.subtitle.textColor = UIColor.black
                self.dateText.font = subtitleNormalFont
                self.dateText.textColor = UIColor.black
            }
            
            // Show/hide the "next appointment" label
            self.nextApptLabel.isHidden = !isNextAppointment
            
            // Hide the subtitle
            self.subtitle.isHidden = true
            
            // Hide the icon
            self.icon.isHidden = true
            
            // Set title frame
            self.title.frame = CGRect(x: xOffset + size.x + gap, y: yOffset, width: textWidth, height: size.y)
            
            /*switch appointment.type! {
            case .Surgery:
                let iconName: String = inPast ? "appointment-icon-filled" : "appointment-icon"
                self.setIconImage(iconName)
                
            default:
                let iconName: String = inPast ? "appointment-icon-filled" : "appointment-icon"
                self.setIconImage(iconName)
            }*/
        }
        // Display "add" buttons for appointments that exist but are not yet scheduled
        else {
            // Set text
            self.title.text = self.appointment?.title
            self.subtitle.text = "Tap to add date"
            self.detail.text = ""
            self.dateText.text = ""
            
            // Set text font and color
            self.title.font = titleItalicFont
            self.title.textColor = UIColor.black
            self.dateText.font = subtitleBoldFont
            self.dateText.textColor = UIColor.black
            
            // Hide the "next appointment" label
            self.nextApptLabel.isHidden = true
            
            // Show the subtitle
            self.subtitle.isHidden = false
            
            // Show the icon
            self.icon.isHidden = false
            self.icon.image = infoIcon
            
            // Update the icon frame
            let iconSize: CGFloat = 30
            let iconOffsetX: CGFloat = 10 + ((70 - iconSize) / 2)
            let iconOffsetY: CGFloat = (self.frame.height - iconSize) / 2
            self.icon.frame = CGRect(x: iconOffsetX, y: iconOffsetY, width: iconSize, height: iconSize)
            
            // Set the title frame
            self.title.frame = CGRect(x: xOffset + size.x + gap, y: yOffset - 10, width: textWidth, height: size.y)
        }
        
        // Update subview rects
        self.subtitle.frame = CGRect(x: xOffset + size.x + gap, y: yOffset + 10, width: textWidth, height: size.y)
        self.detail.frame = CGRect(x: xOffset + size.x + gap - 2, y: yOffset + size.y - 10, width: textWidth, height: 120)
        self.dateText.frame = CGRect(x: xOffset, y: 12, width: 70, height: 66.0)
        self.nextApptLabel.frame = CGRect(x: self.frame.width - 110, y: 0/*self.frame.height - 20*/, width: 110, height: 20)
    }
    
    private func setIconImage(_ name: String) {
        var image: UIImage = UIImage(named: name)!
        self.icon.image = image
        
        var blankImage: UIImage = UIImage(named: "blank-icon")!
        blankImage = blankImage.withRenderingMode(.alwaysTemplate)
        self.imageView?.image = blankImage
        self.imageView?.tintColor = UIColor.clear
    }
}
