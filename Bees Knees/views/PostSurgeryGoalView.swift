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
        goalView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(goalView)
        
        self.addConstraint(NSLayoutConstraint(item: goalView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 80))
        self.addConstraint(NSLayoutConstraint(item: goalView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: goalView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.4, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: goalView, attribute: .height, relatedBy: .equal, toItem: goalView, attribute: .width, multiplier: 1.0, constant: 0))
        
        // Add the next button
        let nextButton: HighlightButton = HighlightButton()
        nextButton.setTitle("Continue", for: .normal)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.addTarget(self, action: #selector(PostSurgeryGoalView.continuePressed), for: .touchUpInside)
        
        self.addSubview(nextButton)
        
        self.addConstraint(NSLayoutConstraint(item: nextButton, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -30))
        self.addConstraint(NSLayoutConstraint(item: nextButton, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: nextButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 160))
        self.addConstraint(NSLayoutConstraint(item: nextButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 42))
        
        // Add the static text
        let label: UITextView = UITextView()
        label.text = "Goals help us in focusing our energy toward concrete steps to a full and successful recovery. When you first started this journey with the app, you set a goal. What did you say you're looking forward to doing once you're back on your feet?"
        label.font = UIFont(name: "ArialMT", size: 14)
        label.textAlignment = .center
        label.isEditable = false
        label.isSelectable = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(label)
        
        self.addConstraint(NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: goalView, attribute: .bottom, multiplier: 1.0, constant: 20))
        self.addConstraint(NSLayoutConstraint(item: label, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -20))
        self.addConstraint(NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 20))
        self.addConstraint(NSLayoutConstraint(item: label, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 140))
        
        // Set the goal text to display
        var goalTextRaw: String = ProfileManager.sharedInstance.goal
        if goalTextRaw == "" {
            goalTextRaw = "This is just a sample goal to display since the user has entered an empty goal."
        }
        
        // Add the static text
        let goalText: UITextView = UITextView()
        goalText.text = "\"" + goalTextRaw + "\""
        goalText.font = UIFont(name: "Arial-ItalicMT", size: 14)
        goalText.textAlignment = .left
        goalText.isEditable = false
        goalText.isSelectable = false
        goalText.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(goalText)
        
        self.addConstraint(NSLayoutConstraint(item: goalText, attribute: .top, relatedBy: .equal, toItem: label, attribute: .bottom, multiplier: 1.0, constant: 30))
        self.addConstraint(NSLayoutConstraint(item: goalText, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -30))
        self.addConstraint(NSLayoutConstraint(item: goalText, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 30))
        self.addConstraint(NSLayoutConstraint(item: goalText, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 60))
    }
    
    
    // MARK: - Helper functions
    func continuePressed() {
        self.delegate?.completePostSurgeryGoal(sender: self)
    }
}
