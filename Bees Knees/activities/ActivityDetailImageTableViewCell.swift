//
//  ActivityDetailImageTableViewCell.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 2/2/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import UIKit
import CareKit


class ActivityDetailImageTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    let TopMargin: CGFloat = 15.0
    let BottomMargin: CGFloat = 15.0
    let LeadingMargin: CGFloat = 20.0
    let TrailingMargin: CGFloat = 20.0
    
    var activityContainer: ActivityContainer? {
        didSet {
            self.updateView()
        }
    }
    
    var _imageView: UIImageView = UIImageView()
    
    
    // MARK: - Initialization
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.prepareView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // MARK: - Helper functions
    func prepareView() {
        _imageView.contentMode = .scaleAspectFit
        self.addSubview(_imageView)
        
        self.setupConstraints()
    }
    
    func updateView() {
        let image: UIImage = UIImage(named: (activityContainer?.activity.image.name)!)!
        _imageView.image = image
    }
    
    func setupConstraints() {
        _imageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addConstraint(NSLayoutConstraint(item: _imageView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: _imageView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: _imageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: _imageView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0))
    }
}
