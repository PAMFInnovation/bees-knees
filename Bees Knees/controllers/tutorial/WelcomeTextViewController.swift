//
//  WelcomeTextViewController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 1/2/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import UIKit


class WelcomeTextViewController: UIViewController {
    
    // Text to display
    var textView: UITextView = UITextView()
    
    // Text and font size
    var text: String = ""
    var fontSize: CGFloat = 0.0
    
    // State for displaying swipe tip
    var shouldDisplaySwipeTip: Bool = false
    var swipeLabel: UILabel = UILabel()
    
    
    // MARK: - Initialization
    convenience init(text: String, fontSize: CGFloat) {
        self.init(nibName: nil, bundle: nil)
        
        self.text = text
        self.fontSize = fontSize
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the text view
        textView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 240)
        textView.font = UIFont.systemFont(ofSize: self.fontSize, weight: UIFontWeightLight)
        textView.textColor = UIColor.white
        textView.backgroundColor = UIColor.clear
        textView.textAlignment = .center
        textView.text = self.text
        textView.isEditable = false
        textView.isSelectable = false
        textView.layer.shadowOpacity = 1.0
        textView.layer.shadowRadius = 0.0
        textView.layer.shadowColor = UIColor.black.cgColor
        textView.layer.shadowOffset = CGSize(width: 1, height: 1)
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        // Attach the text
        self.view.addSubview(textView)
        
        self.view.addConstraint(NSLayoutConstraint(item: textView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 20))
        self.view.addConstraint(NSLayoutConstraint(item: textView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: -20))
         self.view.addConstraint(NSLayoutConstraint(item: textView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0))
         self.view.addConstraint(NSLayoutConstraint(item: textView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 240))
        
        // Add the swipe label
        swipeLabel.frame = CGRect(x: 0, y: self.view.frame.height - 100, width: self.view.frame.width, height: 40)
        swipeLabel.text = "Swipe to continue"
        swipeLabel.textAlignment = .center
        swipeLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightLight)
        swipeLabel.textColor = UIColor.white
        swipeLabel.alpha = 0
        self.view.addSubview(swipeLabel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if shouldDisplaySwipeTip {
            Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.displaySwipeTip), userInfo: nil, repeats: false)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if shouldDisplaySwipeTip {
            self.swipeLabel.alpha = 0
        }
    }
    
    // MARK: - Helper functions
    func displaySwipeTip() {
        UIView.animate(withDuration: 1, animations: {
            self.swipeLabel.alpha = 0.8
        })
    }
}
