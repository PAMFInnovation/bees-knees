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
    
    var nextButton: HighlightButton?
    
    var delegate: PostSurgeryCongratsDelegate!
    
    var selectedMood: UIView?
    
    
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
        checkmarkView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(checkmarkView)
        
        self.addConstraint(NSLayoutConstraint(item: checkmarkView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 80))
        self.addConstraint(NSLayoutConstraint(item: checkmarkView, attribute: .centerXWithinMargins, relatedBy: .equal, toItem: self, attribute: .centerXWithinMargins, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: checkmarkView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 150))
        self.addConstraint(NSLayoutConstraint(item: checkmarkView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 130))
        
        // Add the next button
        nextButton = HighlightButton()
        nextButton?.setTitle("Continue", for: .normal)
        nextButton?.translatesAutoresizingMaskIntoConstraints = false
        nextButton?.addTarget(self, action: #selector(PostSurgeryCongratsView.continuePressed), for: .touchUpInside)
        nextButton?.isEnabled = false
        
        self.addSubview(nextButton!)
        
        self.addConstraint(NSLayoutConstraint(item: nextButton!, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -30))
        self.addConstraint(NSLayoutConstraint(item: nextButton!, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: nextButton!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 160))
        self.addConstraint(NSLayoutConstraint(item: nextButton!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 42))
        
        // Add the header
        let headerLabel: UITextView = UITextView()
        headerLabel.text = "Congratulations!\n\nYou're on your way! Before you return to the app menu, we want to ask you a few things.\n\nHow do you feel right now?"
        headerLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightRegular)
        headerLabel.textAlignment = .center
        headerLabel.isEditable = false
        headerLabel.isSelectable = false
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(headerLabel)
        
        self.addConstraint(NSLayoutConstraint(item: headerLabel, attribute: .top, relatedBy: .equal, toItem: checkmarkView, attribute: .bottom, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: headerLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -30))
        self.addConstraint(NSLayoutConstraint(item: headerLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 30))
        self.addConstraint(NSLayoutConstraint(item: headerLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 170))
        
        // Add the answer choices
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let imageSize: CGFloat = 60
        let sadIV = UIImageView()
        sadIV.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
        sadIV.widthAnchor.constraint(equalToConstant: imageSize).isActive = true
        sadIV.image = UIImage(named: "painscale_painful")
        sadIV.isUserInteractionEnabled = true
        self.addTapListenerToView(sadIV)
        stackView.addArrangedSubview(sadIV)
        let neutralIV = UIImageView()
        neutralIV.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
        neutralIV.widthAnchor.constraint(equalToConstant: imageSize).isActive = true
        neutralIV.image = UIImage(named: "painscale_neutral")
        neutralIV.isUserInteractionEnabled = true
        self.addTapListenerToView(neutralIV)
        stackView.addArrangedSubview(neutralIV)
        let happyIV = UIImageView()
        happyIV.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
        happyIV.widthAnchor.constraint(equalToConstant: imageSize).isActive = true
        happyIV.image = UIImage(named: "painscale_happy")
        happyIV.isUserInteractionEnabled = true
        self.addTapListenerToView(happyIV)
        stackView.addArrangedSubview(happyIV)
        
        self.addSubview(stackView)
        
        self.addConstraint(NSLayoutConstraint(item: stackView, attribute: .top, relatedBy: .equal, toItem: headerLabel, attribute: .bottom, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: stackView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: stackView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 240))
        self.addConstraint(NSLayoutConstraint(item: stackView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 80))
    }
    
    
    // MARK: - Helper functions
    func continuePressed() {
        self.delegate?.completePostSurgeryCongrats(sender: self)
    }
    
    func addTapListenerToView(_ view: UIView) {
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(PostSurgeryCongratsView.selectMood))
        view.addGestureRecognizer(tap)
    }
    
    func selectMood(tap: UITapGestureRecognizer) {
        // Check for tap within the view's rect
        if tap.state == .ended {
            let point = tap.location(in: self)
            if self.frame.contains(point) {
                let animateDuration: CGFloat = 0.1
                
                if selectedMood == tap.view {
                    UIView.animate(withDuration: TimeInterval(animateDuration), delay: 0.0, options: .curveEaseOut, animations: {
                        self.selectedMood?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    }, completion: nil)
                    
                    selectedMood = nil
                }
                else if selectedMood != nil {
                    UIView.animate(withDuration: TimeInterval(animateDuration), delay: 0.0, options: .curveEaseOut, animations: {
                        self.selectedMood?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    }, completion: nil)
                    
                    selectedMood = tap.view
                    
                    UIView.animate(withDuration: TimeInterval(animateDuration), delay: 0.0, options: .curveEaseOut, animations: {
                        self.selectedMood?.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
                    }, completion: nil)
                }
                else {
                    selectedMood = tap.view
                    
                    UIView.animate(withDuration: TimeInterval(animateDuration), delay: 0.0, options: .curveEaseOut, animations: {
                        self.selectedMood?.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
                    }, completion: nil)
                }
                
                nextButton?.isEnabled = selectedMood != nil
            }
        }
    }
}
