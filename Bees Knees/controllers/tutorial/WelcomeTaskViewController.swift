//
//  WelcomeTaskViewController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 2/1/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import UIKit


protocol WelcomeTaskViewControllerDelegate: class {
    func completeTask(sender: WelcomeTaskViewController)
}

class WelcomeTaskViewController: UIViewController {
    
    weak var delegate: WelcomeTaskViewControllerDelegate?
    
    // Icon to display
    var icon: UIImageView = UIImageView()
    var iconName: String = ""
    
    // Main text to display
    var mainTextView: UITextView = UITextView()
    
    // Secondary text to display
    var secondaryTextView: UITextView = UITextView()
    
    // Completed label and icon
    var completedStackView: UIStackView = UIStackView()
    var completedLabel: UILabel = UILabel()
    var completedIcon: UIImageView = UIImageView()
    
    // Text and font size
    var mainText: String = ""
    var secondaryText: String = ""
    var mainFontSize: CGFloat = 0.0
    var secondaryFontSize: CGFloat = 0.0
    
    // State for displaying swipe tip
    var shouldDisplaySwipeTip: Bool = false
    var swipeLabel: UILabel = UILabel()
    
    
    // MARK: - Initialization
    convenience init(mainText: String, secondaryText: String, mainFontSize: CGFloat, secondaryFontSize: CGFloat, icon: String, displaySwipeTip: Bool = false) {
        self.init(nibName: nil, bundle: nil)
        
        self.mainText = mainText
        self.secondaryText = secondaryText
        self.mainFontSize = mainFontSize
        self.secondaryFontSize = secondaryFontSize
        self.iconName = icon
        self.shouldDisplaySwipeTip = displaySwipeTip
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the icon
        var image: UIImage = UIImage(named: self.iconName)!
        self.icon.image = image
        self.icon.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(icon)
        
        let iconSize: CGFloat = 100
        
        self.view.addConstraint(NSLayoutConstraint(item: icon, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: icon, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 40))
        self.view.addConstraint(NSLayoutConstraint(item: icon, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: iconSize))
        self.view.addConstraint(NSLayoutConstraint(item: icon, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: iconSize))
        
        
        // Setup the main text view
        mainTextView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 240)
        mainTextView.font = UIFont.init(name: "HelveticaNeue-Bold", size: self.mainFontSize)// UIFont.systemFont(ofSize: self.mainFontSize, weight: UIFontWeightLight)
        mainTextView.textColor = UIColor.white
        mainTextView.backgroundColor = UIColor.clear
        mainTextView.textAlignment = .center
        mainTextView.text = self.mainText
        mainTextView.isEditable = false
        mainTextView.isSelectable = false
        mainTextView.isScrollEnabled = false
        mainTextView.translatesAutoresizingMaskIntoConstraints = false
        
        // Attach the main text
        self.view.addSubview(mainTextView)
        
        self.view.addConstraint(NSLayoutConstraint(item: mainTextView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 10))
        self.view.addConstraint(NSLayoutConstraint(item: mainTextView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: -10))
        self.view.addConstraint(NSLayoutConstraint(item: mainTextView, attribute: .top, relatedBy: .equal, toItem: icon, attribute: .bottom, multiplier: 1.0, constant: 10))
        
        
        // Setup the secondary text view
        secondaryTextView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 240)
        secondaryTextView.font = UIFont.init(name: "HelveticaNeue", size: self.secondaryFontSize) //UIFont.systemFont(ofSize: self.secondaryFontSize, weight: UIFontWeightLight)
        secondaryTextView.textColor = UIColor.white
        secondaryTextView.backgroundColor = UIColor.clear
        secondaryTextView.textAlignment = .center
        secondaryTextView.text = self.secondaryText
        secondaryTextView.isEditable = false
        secondaryTextView.isSelectable = false
        secondaryTextView.isScrollEnabled = false
        secondaryTextView.translatesAutoresizingMaskIntoConstraints = false
        
        // Attach the secondary text
        self.view.addSubview(secondaryTextView)
        
        self.view.addConstraint(NSLayoutConstraint(item: secondaryTextView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 10))
        self.view.addConstraint(NSLayoutConstraint(item: secondaryTextView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: -10))
        self.view.addConstraint(NSLayoutConstraint(item: secondaryTextView, attribute: .top, relatedBy: .equal, toItem: mainTextView, attribute: .bottom, multiplier: 1.0, constant: 15))
        
        
        // Add the completed icon and text
        completedStackView.axis = .horizontal
        completedStackView.distribution = .fill
        completedStackView.alignment = .center
        completedStackView.spacing = 10
        completedStackView.translatesAutoresizingMaskIntoConstraints = false
        completedStackView.transform = CGAffineTransform(scaleX: 0, y: 0)
        
        let imageSize: CGFloat = 50
        var checkmarkImage: UIImage = UIImage(named: "checkmark-circle")!
        checkmarkImage = checkmarkImage.withRenderingMode(.alwaysTemplate)
        completedIcon = UIImageView(image: checkmarkImage)
        completedIcon.tintColor = UIColor.white
        completedIcon.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
        completedIcon.widthAnchor.constraint(equalToConstant: imageSize).isActive = true
        completedStackView.addArrangedSubview(completedIcon)
        
        completedLabel.text = "Completed!"
        completedLabel.textAlignment = .left
        completedLabel.font = UIFont.init(name: "HelveticaNeue-Bold", size: 28)// UIFont.systemFont(ofSize: 24)
        completedLabel.textColor = UIColor.white
        completedStackView.addArrangedSubview(completedLabel)
        
        self.view.addSubview(completedStackView)
        
        self.view.addConstraint(NSLayoutConstraint(item: completedStackView, attribute: .top, relatedBy: .equal, toItem: secondaryTextView, attribute: .bottom, multiplier: 1.0, constant: 20))
        self.view.addConstraint(NSLayoutConstraint(item: completedStackView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: completedStackView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 240))
        self.view.addConstraint(NSLayoutConstraint(item: completedStackView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 60))
        
        
        // Add the swipe label
        if self.shouldDisplaySwipeTip {
            swipeLabel.frame = CGRect(x: 0, y: self.view.frame.height - 80, width: self.view.frame.width, height: 40)
            swipeLabel.text = "Swipe to continue"
            swipeLabel.textAlignment = .center
            swipeLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightLight)
            swipeLabel.textColor = UIColor.white
            self.view.addSubview(swipeLabel)
        }
    }
    
    
    // MARK: - Helper functions
    func grayOutText() {
        mainTextView.textColor = UIColor.init(white: 1.0, alpha: 0.6)
        secondaryTextView.textColor = UIColor.init(white: 1.0, alpha: 0.6)
        //mainTextView.textColor = UIColor.lightGray
        //secondaryTextView.textColor = UIColor.darkGray
    }
    
    func markAsCompleted() {
        UIView.animate(withDuration: 0.4, animations: {
            self.completedStackView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: { finished in
            UIView.animate(withDuration: 0.1, animations: {
                self.completedStackView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: { finished in
                Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(self.advance), userInfo: nil, repeats: false)
            })
        })
    }
    
    func advance() {
        self.delegate?.completeTask(sender: self)
    }
}
