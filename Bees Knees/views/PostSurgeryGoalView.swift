//
//  PostSurgeryGoalView.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/7/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit


protocol PostSurgeryGoalDelegate: class {
    func completePostSurgeryGoal(sender: PostSurgeryGoalView)
}

class PostSurgeryGoalView: UIView {
    
    var delegate: PostSurgeryGoalDelegate?
    
    
    // MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        // Add the goal icon
        var goalImage: UIImage = UIImage(named: "goal-icon")!
        goalImage = goalImage.withRenderingMode(.alwaysTemplate)
        let goalView: UIImageView = UIImageView(image: goalImage)
        goalView.tintColor = UIColor(colorLiteralRed: 0, green: 0.5, blue: 1, alpha: 1)
        goalView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(goalView)
        
        self.addConstraint(NSLayoutConstraint(item: goalView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 80))
        self.addConstraint(NSLayoutConstraint(item: goalView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: goalView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 150))
        self.addConstraint(NSLayoutConstraint(item: goalView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 150))
        
        // Add the next button
        let nextButton: UIButton = UIButton(type: .roundedRect)
        nextButton.setTitle("Continue", for: .normal)
        nextButton.borderWidth = 1
        nextButton.borderColor = UIColor(colorLiteralRed: 0, green: 0.5, blue: 1, alpha: 1)
        nextButton.cornerRadius = 10
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.addTarget(self, action: #selector(PostSurgeryGoalView.continuePressed), for: .touchUpInside)
        
        self.addSubview(nextButton)
        
        self.addConstraint(NSLayoutConstraint(item: nextButton, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -60))
        self.addConstraint(NSLayoutConstraint(item: nextButton, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: nextButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 200))
        self.addConstraint(NSLayoutConstraint(item: nextButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 42))
        
        // Add the static text
        let label: UITextView = UITextView()
        label.text = "When you first started using this App, you set a goal:"
        label.font = UIFont(name: "Arial-BoldMT", size: 18)
        label.textAlignment = .center
        label.isEditable = false
        label.isSelectable = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(label)
        
        self.addConstraint(NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: goalView, attribute: .bottom, multiplier: 1.0, constant: 20))
        self.addConstraint(NSLayoutConstraint(item: label, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -30))
        self.addConstraint(NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 30))
        self.addConstraint(NSLayoutConstraint(item: label, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 80))
        
        // Add the static text
        let goalText: UITextView = UITextView()
        goalText.text = "\"" + ProfileManager.sharedInstance.goal + "\""
        goalText.font = UIFont(name: "Arial-ItalicMT", size: 18)
        goalText.textAlignment = .left
        goalText.isEditable = false
        goalText.isSelectable = false
        goalText.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(goalText)
        
        self.addConstraint(NSLayoutConstraint(item: goalText, attribute: .top, relatedBy: .equal, toItem: label, attribute: .bottom, multiplier: 1.0, constant: 30))
        self.addConstraint(NSLayoutConstraint(item: goalText, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -30))
        self.addConstraint(NSLayoutConstraint(item: goalText, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 30))
        self.addConstraint(NSLayoutConstraint(item: goalText, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 80))
    }
    
    
    // MARK: - Helper functions
    func continuePressed() {
        self.delegate?.completePostSurgeryGoal(sender: self)
    }
}
