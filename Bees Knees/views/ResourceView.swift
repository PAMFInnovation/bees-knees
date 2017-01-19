//
//  ResourceView.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 1/19/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import UIKit


class ResourceView: UIView {
    
    // MARK: - Properties
    var title: UILabel = UILabel()
    var expandedFrame: CGRect
    
    
    // MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        expandedFrame = CGRect.zero
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        expandedFrame = frame
        super.init(frame: frame)
        
        // Set a rounded corner
        self.cornerRadius = 20.0
        
        self.backgroundColor = UIColor.blue
        
        // Setup the title label
        title.frame = CGRect(x: 0, y: 0, width: frame.width, height: 50)
        title.backgroundColor = UIColor.yellow
        title.font = UIFont.systemFont(ofSize: 18)
        title.textColor = UIColor.black
        //self.addSubview(title)
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    
    // MARK: - Helper functions
    func expand(from frame: CGRect) {
        /*// Set the initial frame
        self.frame = frame
        // Set the initial background color of the frame
        self.backgroundColor = UIColor("#00AAA6")
        
        // Reveal the view
        self.isHidden = false
        
        // Animate to the new frame dimensions
        UIView.animate(withDuration: 0.6, delay: 0.1, options: .curveEaseOut, animations: {
            self.frame = self.expandedFrame
            self.backgroundColor = UIColor.black
        }, completion: nil)*/
    }
}
