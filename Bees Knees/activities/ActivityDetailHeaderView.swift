//
//  ActivityDetailHeaderViewController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 2/2/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import UIKit
import CareKit


class ActivityDetailHeaderView: UIView {
    
    // MARK: - Properties
    let LeadingMargin: CGFloat = 20.0
    let TrailingMargin: CGFloat = 20.0
    let BottomMargin: CGFloat = 15.0
    let TopMargin: CGFloat = 20.0
    
    var activity: ActivityContainer? {
        didSet {
            self.updateView()
        }
    }
    
    var titleLabel: UILabel = UILabel()
    var textLabel: UILabel = UILabel()
    var bottomEdge: UIView = UIView()
    
    
    // MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.prepareView()
    }
    
    
    // MARK: - Helper functions
    func prepareView() {
        self.backgroundColor = UIColor.white
        
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        self.addSubview(titleLabel)
        
        textLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        textLabel.textColor = UIColor.lightGray
        textLabel.lineBreakMode = .byWordWrapping
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .center
        self.addSubview(textLabel)
        
        self.addSubview(bottomEdge)
        
        self.updateView()
        self.setupConstraints()
    }
    
    func updateView() {
        self.tintColor = activity?.carePlanActivity.tintColor
        titleLabel.text = activity?.carePlanActivity.title
        textLabel.text = activity?.carePlanActivity.text
        bottomEdge.backgroundColor = self.tintColor
    }
    
    func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomEdge.translatesAutoresizingMaskIntoConstraints = false
        
        self.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: TopMargin))
        self.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: LeadingMargin))
        self.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -TrailingMargin))
        self.addConstraint(NSLayoutConstraint(item: textLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: LeadingMargin))
        self.addConstraint(NSLayoutConstraint(item: textLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -TrailingMargin))
        self.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .bottom, relatedBy: .equal, toItem: textLabel, attribute: .top, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: textLabel, attribute: .bottom, multiplier: 1.0, constant: BottomMargin))
        self.addConstraint(NSLayoutConstraint(item: bottomEdge, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: bottomEdge, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 3.0))
        self.addConstraint(NSLayoutConstraint(item: bottomEdge, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1.0, constant: 0.0))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.preferredMaxLayoutWidth = titleLabel.bounds.size.width
        textLabel.preferredMaxLayoutWidth = textLabel.bounds.size.width
    }
    
    func setShowEdgeIndicator(_ showEdgeIndicator: Bool) {
        bottomEdge.isHidden = !showEdgeIndicator
    }
    
    override func tintColorDidChange() {
        super.tintColorDidChange()
        
        self.updateView()
    }
}
