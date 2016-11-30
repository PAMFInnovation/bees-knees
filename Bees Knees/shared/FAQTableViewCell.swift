//
//  FAQTableViewCell.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/16/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit


class FAQTableViewCell: UITableViewCell {
    
    // Custom views
    var icon = UIImageView()
    var question = UILabel()
    var answer = UITextView()
    var caret = UILabel()
    
    // Keep a reference to the collapsed height
    let collapsedHeight: CGFloat = 60
    var expandedHeight: CGFloat = 0
    
    
    // MARK: - Initialization
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        
        // Set content clipping
        self.autoresizingMask = .flexibleHeight
        self.clipsToBounds = true
        
        // Customize subviews
        var image: UIImage = UIImage(named: "faq-icon")!
        image = image.withRenderingMode(.alwaysTemplate)
        self.icon.image = image
        
        self.question.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightSemibold)
        self.question.numberOfLines = 0
        self.question.lineBreakMode = .byWordWrapping
        //self.question.backgroundColor = UIColor.yellow
        
        self.caret.font = UIFont(name: "ArialMT", size: 12)
        self.caret.textAlignment = .right
        self.caret.textColor = UIColor.lightGray
        self.deselect()
        //self.caret.backgroundColor = UIColor.red
        
        self.answer.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightRegular)
        self.answer.textAlignment = .justified
        self.answer.isEditable = false
        self.answer.isSelectable = false
        self.answer.isScrollEnabled = false
        //self.answer.backgroundColor = UIColor.lightGray
        
        // Add custom subviews
        self.addSubview(icon)
        self.addSubview(question)
        self.addSubview(answer)
        self.addSubview(caret)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let iconOffset: CGPoint = CGPoint(x: 10, y: collapsedHeight * 0.1)
        let iconSize = collapsedHeight - (iconOffset.y * 2)
        let labelXOffset = iconOffset.x + iconSize + 10
        
        self.icon.frame = CGRect(x: iconOffset.x, y: iconOffset.y, width: iconSize, height: iconSize)

        self.question.frame = CGRect(x: labelXOffset, y: iconOffset.y, width: self.frame.width - labelXOffset - 35, height: iconSize)
        self.caret.frame = CGRect(x: self.question.frame.minX + self.question.frame.width + 5, y: iconOffset.y, width: 15, height: iconSize)
        
        self.answer.frame = CGRect(x: labelXOffset - 4, y: collapsedHeight + iconOffset.y, width: self.frame.width - labelXOffset - 35, height: 100)
        self.answer.sizeToFit()
        
        expandedHeight = self.answer.frame.height + collapsedHeight + 20
    }
    
    
    // MARK: - Helper functions
    func select() {
        //self.caret.text = "\u{25B4}"
    }
    
    func deselect() {
        self.caret.text = "\u{25BE}"
    }
    
    func getHeight(_ isExpanded: Bool) -> CGFloat {
        return isExpanded ? expandedHeight : collapsedHeight
    }
}
