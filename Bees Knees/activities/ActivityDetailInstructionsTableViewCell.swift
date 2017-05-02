//
//  ActivityDetailInstructionsTableViewCell.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 2/2/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import UIKit
import CareKit


class ActivityDetailInstructionsTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    let TopMargin: CGFloat = 15.0
    let BottomMargin: CGFloat = 15.0
    let LeadingMargin: CGFloat = 20.0
    let TrailingMargin: CGFloat = 20.0
    let ContentHeight: CGFloat = 200.0
    
    var activityContainer: ActivityContainer? {
        didSet {
            self.updateView()
        }
    }
    
    var _videoContainerView: UIView = UIView()
    var _webView: UIWebView = UIWebView()
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
        self.addSubview(_videoContainerView)
        
        _webView.contentMode = .scaleAspectFit
        _webView.scrollView.isScrollEnabled = false
        //_webView.allowsInlineMediaPlayback = true
        //_webView.mediaPlaybackAllowsAirPlay = true
        _webView.mediaPlaybackRequiresUserAction = true
        _videoContainerView.addSubview(_webView)
        
        _textLabel.font = UIFont.preferredFont(forTextStyle: .body)
        _textLabel.numberOfLines = 0
        _textLabel.lineBreakMode = .byWordWrapping
        self.addSubview(_textLabel)
        
        self.setupConstraints()
    }
    
    func updateView() {
        _textLabel.text = activityContainer?.carePlanActivity.instructions
        
        if activityContainer?.activity.video == "" {
            print("Video file not found")
            _videoContainerView.isHidden = true
            return
        } else {
            let path = Bundle.main.path(forResource: (activityContainer?.activity.video)!, ofType: ("mp4"))
            _videoContainerView.isHidden = false
            self.addConstraint(NSLayoutConstraint(item: _videoContainerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: ContentHeight))
            
            let srcURL = URL(fileURLWithPath: path!)
            let htmlString = "<iframe width=\"100%\" src=\"\(srcURL)\"></iframe>"
            _webView.loadHTMLString(htmlString, baseURL: nil)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setupConstraints() {
        _videoContainerView.translatesAutoresizingMaskIntoConstraints = false
        _textLabel.translatesAutoresizingMaskIntoConstraints = false
        _webView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addConstraint(NSLayoutConstraint(item: _videoContainerView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: _videoContainerView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: _videoContainerView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: TopMargin))
        self.addConstraint(NSLayoutConstraint(item: _videoContainerView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
        
        self.addConstraint(NSLayoutConstraint(item: _textLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: LeadingMargin))
        self.addConstraint(NSLayoutConstraint(item: _textLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -TrailingMargin))
        self.addConstraint(NSLayoutConstraint(item: _textLabel, attribute: .top, relatedBy: .equal, toItem: _videoContainerView, attribute: .bottom, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: _textLabel, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -BottomMargin))
        
        self.addConstraint(NSLayoutConstraint(item: _webView, attribute: .leading, relatedBy: .equal, toItem: _videoContainerView, attribute: .leading, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: _webView, attribute: .trailing, relatedBy: .equal, toItem: _videoContainerView, attribute: .trailing, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: _webView, attribute: .top, relatedBy: .equal, toItem: _videoContainerView, attribute: .top, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: _webView, attribute: .bottom, relatedBy: .equal, toItem: _videoContainerView, attribute: .bottom, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: _webView, attribute: .centerX, relatedBy: .equal, toItem: _videoContainerView, attribute: .centerX, multiplier: 1.0, constant: 0))
    }
}
