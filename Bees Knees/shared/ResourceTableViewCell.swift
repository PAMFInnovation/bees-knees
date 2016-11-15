//
//  ResourceTableViewCell.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/15/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit


class ResourceTableViewCell: UITableViewCell {
    
    // Reference to the resource
    var resource: Resource?
    
    // Custom views
    var icon: UIImageView = UIImageView()
    var title: UILabel = UILabel()
    
    
    // MARK: - Initialization
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        
        // Set a custom background view with transparency
        let bgColorView = UIView()
        bgColorView.backgroundColor = Colors.transTurquoise.color
        self.selectedBackgroundView = bgColorView
        
        // Set content clipping
        self.autoresizingMask = .flexibleHeight
        self.clipsToBounds = true
        
        // Customize subviews
        self.title.font = UIFont(name: "ArialMT", size: 16)
        self.title.numberOfLines = 0
        self.title.lineBreakMode = .byWordWrapping
        
        // Add custom subviews
        self.addSubview(icon)
        self.addSubview(title)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let iconOffset: CGPoint = CGPoint(x: 10, y: self.frame.height * 0.1)
        let iconSize = self.frame.height - (iconOffset.y * 2)
        let labelXOffset = iconOffset.x + iconSize + 10
        
        self.icon.frame = CGRect(x: iconOffset.x, y: iconOffset.y, width: iconSize, height: iconSize)
        self.title.frame = CGRect(x: labelXOffset, y: iconOffset.y, width: self.frame.width - labelXOffset, height: iconSize)
    }
    
    
    // MARK: - Helper functions
    func setResourceObject(_ resource: Resource) {
        self.resource = resource
        
        self.title.text = resource.title
        
        var imageName: String = ""
        switch resource.type! {
        case .DOC:
            imageName = "doc-icon"
            
        case .VIDEO:
            imageName = "video-icon"
            
        case .IMAGE:
            imageName = "image-icon"
            
        default:
            imageName = "image-icon"
        }
        
        var image: UIImage = UIImage(named: imageName)!
        image = image.withRenderingMode(.alwaysTemplate)
        self.icon.image = image
    }
}
