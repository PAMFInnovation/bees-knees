//
//  ActivityDetailRationaleTableViewCell.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 2/2/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import UIKit
import CareKit


class ActivityDetailRationaleTableViewCell: UITableViewCell {
    
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
    
    var _textLabel: UILabel = UILabel()
    
    
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
        _textLabel.font = UIFont.preferredFont(forTextStyle: .body)
        _textLabel.numberOfLines = 0
        _textLabel.lineBreakMode = .byWordWrapping
        self.addSubview(_textLabel)
        
        self.setupConstraints()
    }
    
    func updateView() {
        _textLabel.text = activityContainer?.activity.rationale
    }
    
    func setupConstraints() {
        _textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addConstraint(NSLayoutConstraint(item: _textLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: LeadingMargin))
        self.addConstraint(NSLayoutConstraint(item: _textLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -TrailingMargin))
        self.addConstraint(NSLayoutConstraint(item: _textLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: TopMargin))
        self.addConstraint(NSLayoutConstraint(item: _textLabel, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -BottomMargin))
    }
}
