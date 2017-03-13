//
//  ContactUsViewController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 3/13/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import UIKit


class ContactUsViewController: UIViewController {
    
    // Icon to display
    var icon: UIImageView = UIImageView()
    
    // Main text to display
    var mainTextView: UITextView = UITextView()
    
    // Secondary text to display
    var secondaryTextView: UITextView = UITextView()
    
    
    // MARK: - Initialization
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        // Setup the icon
        var image: UIImage = UIImage(named: "contact_us")!
        self.icon.image = image
        self.icon.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(icon)
        
        let iconSize: CGFloat = 100
        
        self.view.addConstraint(NSLayoutConstraint(item: icon, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: icon, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 100))
        self.view.addConstraint(NSLayoutConstraint(item: icon, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: iconSize))
        self.view.addConstraint(NSLayoutConstraint(item: icon, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: iconSize))
        
        
        // Setup the main text content
        let mainFont = UIFont(name: "HelveticaNeue-Light", size: 16)!
        let mainBoldFont = UIFont(name: "HelveticaNeue-Medium", size: 16)!
        // Setup the main text view
        mainTextView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 240)
        mainTextView.textColor = UIColor.black
        mainTextView.backgroundColor = UIColor.white
        mainTextView.textAlignment = .center
        mainTextView.attributedText = "If you have a medical emergency, please call 911 immediately.\nPlease contact your surgeon's office for all other medical questions.\n\nIf you want to share feedback or have technical issues with the app, please:\n1. Go to the TestFlight app,\n2. Click on the JointCare app, and\n3. Click on Send Feedback.*".withBoldText(boldPartsOfString: ["If you have a medical emergency, please call 911 immediately."], font: mainFont, boldFont: mainBoldFont, alignment: .center)
        mainTextView.isEditable = false
        mainTextView.isSelectable = false
        mainTextView.isScrollEnabled = false
        mainTextView.translatesAutoresizingMaskIntoConstraints = false
        
        // Attach the main text
        self.view.addSubview(mainTextView)
        
        self.view.addConstraint(NSLayoutConstraint(item: mainTextView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 30))
        self.view.addConstraint(NSLayoutConstraint(item: mainTextView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: -30))
        self.view.addConstraint(NSLayoutConstraint(item: mainTextView, attribute: .top, relatedBy: .equal, toItem: icon, attribute: .bottom, multiplier: 1.0, constant: 30))
        
        
        // Setup the secondary text view
        secondaryTextView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 240)
        secondaryTextView.font = UIFont.init(name: "HelveticaNeue-Light", size: 14)
        secondaryTextView.textColor = UIColor.black
        secondaryTextView.backgroundColor = UIColor.white
        secondaryTextView.textAlignment = .center
        secondaryTextView.text = "*Note: A technical support team will receive this feedback and respond within 1-3 business days."
        secondaryTextView.isEditable = false
        secondaryTextView.isSelectable = false
        secondaryTextView.isScrollEnabled = false
        secondaryTextView.translatesAutoresizingMaskIntoConstraints = false
        
        // Attach the secondary text
        self.view.addSubview(secondaryTextView)
        
        self.view.addConstraint(NSLayoutConstraint(item: secondaryTextView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 30))
        self.view.addConstraint(NSLayoutConstraint(item: secondaryTextView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: -30))
        self.view.addConstraint(NSLayoutConstraint(item: secondaryTextView, attribute: .top, relatedBy: .equal, toItem: mainTextView, attribute: .bottom, multiplier: 1.0, constant: 10))
    }
}
