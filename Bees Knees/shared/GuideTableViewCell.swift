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
        
        // Customize labels
        self.title.font = UIFont(name: "Arial-BoldMT", size: 16)
        self.subtitle.font = UIFont(name: "ArialMT", size: 12)
        
        // Customize the detail text view
        self.detail.font = UIFont(name: "ArialMT", size: 12)
        self.detail.isEditable = false
        self.detail.isSelectable = false
        self.detail.backgroundColor = UIColor.clear
        self.detail.contentInset = UIEdgeInsets.zero
        self.detail.isUserInteractionEnabled = false
        
        // Add custom subviews
        self.addSubview(icon)
        self.addSubview(title)
        self.addSubview(subtitle)
        self.addSubview(detail)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    // MARK: - Helper functions
    func setAppointment(appointment: Appointment) {
        self.appointment = appointment
        
        // Set text
        self.title.text = self.appointment?.title
        self.subtitle.text = Util.getFormattedDate((self.appointment?.date!)!, dateFormat: "EEE, MMM d yyyy - h:mma")
        self.detail.text = (self.appointment?.elapsed)! ? "" : Copy.getWildernessGuideCopy(type: appointment.type)
        
        let size: CGFloat = 70.0
        let gap: CGFloat = 10.0
        let xOffset: CGFloat = 8.0
        var yOffset: CGFloat = 0.0
        
        switch appointment.type! {
        case .Surgery:
            self.setIconImage("target-icon")
            yOffset = 8.0
        
        default:
            let iconName: String = Util.isDateInPast((self.appointment?.date)!) ? "appointment-icon-filled" : "appointment-icon"
            self.setIconImage(iconName)
        }
        
        // Update subview rects
        let textWidth = self.frame.width - xOffset - size - gap - 20
        self.icon.frame = CGRect(x: xOffset, y: yOffset, width: size, height: size)
        self.title.frame = CGRect(x: xOffset + size + gap, y: yOffset - 10, width: textWidth, height: size)
        self.subtitle.frame = CGRect(x: xOffset + size + gap, y: yOffset + 10, width: textWidth, height: size)
        self.detail.frame = CGRect(x: xOffset + size + gap - 2, y: yOffset + size, width: textWidth, height: 110)
    }
    
    private func setIconImage(_ name: String) {
        var image: UIImage = UIImage(named: name)!
        //image = image.withRenderingMode(.alwaysTemplate)
        self.icon.image = image
        //self.icon.tintColor = Colors.turquoise.color
        
        var blankImage: UIImage = UIImage(named: "blank-icon")!
        blankImage = blankImage.withRenderingMode(.alwaysTemplate)
        self.imageView?.image = blankImage
        self.imageView?.tintColor = UIColor.clear
    }
}
