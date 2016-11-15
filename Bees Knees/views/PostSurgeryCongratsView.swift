//
//  PostSurgeryCongratsView.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/7/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit


protocol PostSurgeryCongratsDelegate: class {
    func completePostSurgeryCongrats(sender: PostSurgeryCongratsView)
}

class PostSurgeryCongratsView: UIView {
    
    var delegate: PostSurgeryCongratsDelegate!
    
    
    // MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        
        // Add the checkmark
        var checkmarkImage: UIImage = UIImage(named: "checkmark")!
        checkmarkImage = checkmarkImage.withRenderingMode(.alwaysTemplate)
        let checkmarkView: UIImageView = UIImageView(image: checkmarkImage)
        checkmarkView.tintColor = UIColor(colorLiteralRed: 0, green: 0.5, blue: 1, alpha: 1)
        checkmarkView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(checkmarkView)
        
        self.addConstraint(NSLayoutConstraint(item: checkmarkView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 80))
        self.addConstraint(NSLayoutConstraint(item: checkmarkView, attribute: .centerXWithinMargins, relatedBy: .equal, toItem: self, attribute: .centerXWithinMargins, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: checkmarkView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 150))
        self.addConstraint(NSLayoutConstraint(item: checkmarkView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 150))
        
        // Add the next button
        let nextButton: UIButton = UIButton(type: .roundedRect)
        nextButton.setTitle("Continue", for: .normal)
        nextButton.borderWidth = 1
        nextButton.borderColor = UIColor(colorLiteralRed: 0, green: 0.5, blue: 1, alpha: 1)
        nextButton.cornerRadius = 10
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.addTarget(self, action: #selector(PostSurgeryCongratsView.continuePressed), for: .touchUpInside)
        
        self.addSubview(nextButton)
        
        self.addConstraint(NSLayoutConstraint(item: nextButton, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -30))
        self.addConstraint(NSLayoutConstraint(item: nextButton, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: nextButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 200))
        self.addConstraint(NSLayoutConstraint(item: nextButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 42))
        
        // Add the header
        let headerLabel: UILabel = UILabel()
        headerLabel.text = "Congratulations!"
        headerLabel.font = UIFont(name: "Arial-BoldMT", size: 24)
        headerLabel.textAlignment = .center
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(headerLabel)
        
        self.addConstraint(NSLayoutConstraint(item: headerLabel, attribute: .top, relatedBy: .equal, toItem: checkmarkView, attribute: .bottom, multiplier: 1.0, constant: 20))
        self.addConstraint(NSLayoutConstraint(item: headerLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: headerLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: headerLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40))
    }
    
    
    // MARK: - Helper functions
    func continuePressed() {
        self.delegate?.completePostSurgeryCongrats(sender: self)
    }
}
