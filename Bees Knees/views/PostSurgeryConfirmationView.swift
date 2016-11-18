//
//  PostSurgeryConfirmationView.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/8/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit


protocol PostSurgeryConfirmationDelegate: class {
    func confirmConfirmation(sender: PostSurgeryConfirmationView)
    func adjustSurgeryDate(sender: PostSurgeryConfirmationView)
}

class PostSurgeryConfirmationView: UIView {
    
    var delegate: PostSurgeryConfirmationDelegate?
    
    
    // MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        
        // Add the goal icon
        var goalImage: UIImage = UIImage(named: "hospital-icon")!
        goalImage = goalImage.withRenderingMode(.alwaysTemplate)
        let goalView: UIImageView = UIImageView(image: goalImage)
        goalView.tintColor = UIColor(colorLiteralRed: 0, green: 0.5, blue: 1, alpha: 1)
        goalView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(goalView)
        
        self.addConstraint(NSLayoutConstraint(item: goalView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 80))
        self.addConstraint(NSLayoutConstraint(item: goalView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: goalView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 150))
        self.addConstraint(NSLayoutConstraint(item: goalView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 150))
        
        
        // Add the deny button
        let denyButton: HighlightButton = HighlightButton()
        denyButton.setTitle("I haven't had surgery yet.", for: .normal)
        denyButton.translatesAutoresizingMaskIntoConstraints = false
        denyButton.addTarget(self, action: #selector(PostSurgeryConfirmationView.adjustSurgeryDate), for: .touchUpInside)
        
        self.addSubview(denyButton)
        
        self.addConstraint(NSLayoutConstraint(item: denyButton, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -20))
        self.addConstraint(NSLayoutConstraint(item: denyButton, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: denyButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 160))
        self.addConstraint(NSLayoutConstraint(item: denyButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 42))
        
        
        // Add the confirm button
        let confirmButton: HighlightButton = HighlightButton()
        confirmButton.setTitle("Yes!", for: .normal)
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.addTarget(self, action: #selector(PostSurgeryConfirmationView.confirmSurgery), for: .touchUpInside)
        
        self.addSubview(confirmButton)
        
        self.addConstraint(NSLayoutConstraint(item: confirmButton, attribute: .bottom, relatedBy: .equal, toItem: denyButton, attribute: .top, multiplier: 1.0, constant: -20))
        self.addConstraint(NSLayoutConstraint(item: confirmButton, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: confirmButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 160))
        self.addConstraint(NSLayoutConstraint(item: confirmButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 42))
        
        
        // Add the static text
        let label: UITextView = UITextView()
        label.text = "According to the date that you entered in this app, you have completed your surgery. Let's check that -- how did it go?"
        label.font = UIFont(name: "ArialMT", size: 18)
        label.textAlignment = .center
        label.isEditable = false
        label.isSelectable = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(label)
        
        self.addConstraint(NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: goalView, attribute: .bottom, multiplier: 1.0, constant: 20))
        self.addConstraint(NSLayoutConstraint(item: label, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -30))
        self.addConstraint(NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 30))
        self.addConstraint(NSLayoutConstraint(item: label, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100))
        
        
        // Add the static text
        /*let goalText: UITextView = UITextView()
        goalText.text = "Was your surgery successful?"
        goalText.font = UIFont(name: "ArialMT", size: 18)
        goalText.textAlignment = .center
        goalText.isEditable = false
        goalText.isSelectable = false
        goalText.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(goalText)
        
        self.addConstraint(NSLayoutConstraint(item: goalText, attribute: .top, relatedBy: .equal, toItem: label, attribute: .bottom, multiplier: 1.0, constant: 30))
        self.addConstraint(NSLayoutConstraint(item: goalText, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -30))
        self.addConstraint(NSLayoutConstraint(item: goalText, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 30))
        self.addConstraint(NSLayoutConstraint(item: goalText, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 80))*/
    }
    
    
    // MARK: - Helper functions
    func confirmSurgery() {
        self.delegate?.confirmConfirmation(sender: self)
    }
    
    func adjustSurgeryDate() {
        self.delegate?.adjustSurgeryDate(sender: self)
    }
}
