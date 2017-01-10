//
//  PostSurgeryTransitionView.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/7/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit


protocol PostSurgeryTransitionDelegate: class {
    func transitionToPostRoutine(sender: PostSurgeryTransitionView)
}

class PostSurgeryTransitionView: UIView {
    
    var delegate: PostSurgeryTransitionDelegate?
    
    
    // MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        // Add the goal icon
        //var image: UIImage = UIImage(named: "clipboard")!
        var image: UIImage = UIImage(named: "checkmark")!
        image = image.withRenderingMode(.alwaysTemplate)
        let imageView: UIImageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(imageView)
        
        self.addConstraint(NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 80))
        self.addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 150))
        self.addConstraint(NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 150))
        
        // Add the next button
        let nextButton: HighlightButton = HighlightButton()
        nextButton.setTitle("Ok", for: .normal)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.addTarget(self, action: #selector(PostSurgeryTransitionView.goButtonPressed), for: .touchUpInside)
        
        self.addSubview(nextButton)
        
        self.addConstraint(NSLayoutConstraint(item: nextButton, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -30))
        self.addConstraint(NSLayoutConstraint(item: nextButton, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: nextButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 160))
        self.addConstraint(NSLayoutConstraint(item: nextButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 42))
        
        // Add the header
        /*let headerLabel: UILabel = UILabel()
        headerLabel.text = "Post-Surgery"
        headerLabel.font = UIFont(name: "Arial-BoldMT", size: 24)
        headerLabel.textAlignment = .center
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(headerLabel)
        
        self.addConstraint(NSLayoutConstraint(item: headerLabel, attribute: .top, relatedBy: .equal, toItem: imageView, attribute: .bottom, multiplier: 1.0, constant: 20))
        self.addConstraint(NSLayoutConstraint(item: headerLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: headerLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: headerLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40))*/
        
        // Add the static text
        let goalText: UITextView = UITextView()
        goalText.text = "Congratulations!\n\nYou're on your way! Now you have some strengthening exercises awaiting you and progress to record. Let's get started!"
        //goalText.text = "You have some strengthening exercises awaiting you and progress to record. Let's get started!"
        goalText.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightRegular)
        goalText.textAlignment = .center
        goalText.isEditable = false
        goalText.isSelectable = false
        goalText.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(goalText)
        
        self.addConstraint(NSLayoutConstraint(item: goalText, attribute: .top, relatedBy: .equal, toItem: imageView, attribute: .bottom, multiplier: 1.0, constant: 30))
        self.addConstraint(NSLayoutConstraint(item: goalText, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -30))
        self.addConstraint(NSLayoutConstraint(item: goalText, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 30))
        self.addConstraint(NSLayoutConstraint(item: goalText, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 120))
    }
    
    
    // MARK: - Helper functions
    func goButtonPressed() {
        self.delegate?.transitionToPostRoutine(sender: self)
    }
}
