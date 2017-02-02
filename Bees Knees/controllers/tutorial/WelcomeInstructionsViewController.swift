//
//  WelcomeInstructionsViewController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 2/1/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import UIKit


struct WelcomeFeature {
    let icon: String
    let description: String
}

class WelcomeInstructionsViewController: UIViewController {
    
    // Main text to display
    var textView: UITextView = UITextView()
    var text: String = "LegUp is a personalized journal and navigational guide on your road to recovery. It will help you:"
    
    // State for displaying swipe tip
    var swipeLabel: UILabel = UILabel()
    
    // Features
    let features: [WelcomeFeature] = [
        WelcomeFeature(icon: "guide-icon", description: "Keep appointments that lie ahead together and know what to expect"),
        WelcomeFeature(icon: "carecard-icon", description: "Show exercises to build strength and track your completion"),
        WelcomeFeature(icon: "checklist-icon", description: "Manage your to-do's pre-surgery"),
        WelcomeFeature(icon: "insights-icon", description: "Track your pain and mood post-surgery and see how it changes over time"),
        WelcomeFeature(icon: "resources-icon", description: "Access your binder on-the-go")
    ]
    
    
    // MARK: - Initialization
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the text view
        textView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 240)
        textView.font = UIFont.systemFont(ofSize: 22, weight: UIFontWeightLight)
        textView.textColor = UIColor.white
        textView.backgroundColor = UIColor.clear
        textView.textAlignment = .center
        textView.text = text
        textView.isEditable = false
        textView.isSelectable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        // Attach the main text
        self.view.addSubview(textView)
        
        self.view.addConstraint(NSLayoutConstraint(item: textView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 10))
        self.view.addConstraint(NSLayoutConstraint(item: textView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: -10))
        self.view.addConstraint(NSLayoutConstraint(item: textView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 60))
        
        
        // Add the features list
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .fill
        verticalStackView.alignment = .leading
        verticalStackView.spacing = 10
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(verticalStackView)
        
        self.view.addConstraint(NSLayoutConstraint(item: verticalStackView, attribute: .top, relatedBy: .equal, toItem: textView, attribute: .bottom, multiplier: 1.0, constant: 20))
        self.view.addConstraint(NSLayoutConstraint(item: verticalStackView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 20))
        self.view.addConstraint(NSLayoutConstraint(item: verticalStackView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: -20))
        
        for feature in features {
            let featureStackView = UIStackView()
            featureStackView.axis = .horizontal
            featureStackView.distribution = .fill
            featureStackView.alignment = .leading
            featureStackView.spacing = 10
            featureStackView.translatesAutoresizingMaskIntoConstraints = false
            
            let imageSize: CGFloat = 40
            var image: UIImage = UIImage(named: feature.icon)!
            image = image.withRenderingMode(.alwaysTemplate)
            let icon = UIImageView(image: image)
            icon.tintColor = UIColor.white
            icon.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
            icon.widthAnchor.constraint(equalToConstant: imageSize).isActive = true
            icon.backgroundColor = UIColor.clear
            icon.translatesAutoresizingMaskIntoConstraints = false
            featureStackView.addArrangedSubview(icon)
            
            let featureText = UITextView()
            featureText.text = feature.description
            featureText.textAlignment = .left
            featureText.font = UIFont.systemFont(ofSize: 16)
            featureText.textColor = UIColor.white
            featureText.backgroundColor = UIColor.clear
            featureText.isScrollEnabled = false
            featureText.translatesAutoresizingMaskIntoConstraints = false
            featureStackView.addArrangedSubview(featureText)
            
            verticalStackView.addArrangedSubview(featureStackView)
            
            verticalStackView.addConstraint(NSLayoutConstraint(item: featureStackView, attribute: .leading, relatedBy: .equal, toItem: verticalStackView, attribute: .leading, multiplier: 1.0, constant: 0))
            verticalStackView.addConstraint(NSLayoutConstraint(item: featureStackView, attribute: .trailing, relatedBy: .equal, toItem: verticalStackView, attribute: .trailing, multiplier: 1.0, constant: 0))
        }
        
        
        // Add the swipe label
        let swipeLabel = UILabel()
        swipeLabel.frame = CGRect(x: 0, y: self.view.frame.height - 80, width: self.view.frame.width, height: 40)
        swipeLabel.text = "Swipe to continue"
        swipeLabel.textAlignment = .center
        swipeLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightLight)
        swipeLabel.textColor = UIColor.white
        self.view.addSubview(swipeLabel)
    }
}
