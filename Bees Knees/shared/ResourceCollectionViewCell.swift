//
//  ResourceCollectionViewCell.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 1/18/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import UIKit


protocol ResourceCollectionViewCellDelegate: class {
    func didSelect(sender: ResourceCollectionViewCell)
}

class ResourceCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    var textView: UITextView = UITextView()
    var delegate: ResourceCollectionViewCellDelegate?
    
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Add the rounded frame
        let roundView: UIView = UIView(frame: frame)
        roundView.frame.origin = CGPoint.zero
        roundView.backgroundColor = UIColor("#00AAA6")
        roundView.shadow = true
        roundView.cornerRadius = 20.0
        roundView.isUserInteractionEnabled = false
        self.addSubview(roundView)
        
        // Setup the main text view
        textView.frame.origin = CGPoint.zero
        textView.frame.size = frame.size
        textView.backgroundColor = UIColor.clear
        textView.textAlignment = .center
        textView.textColor = UIColor.white
        textView.isEditable = false
        textView.isSelectable = false
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.isUserInteractionEnabled = false
        textView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        self.addSubview(textView)
        
        // Add a tap gesture for selecting the cell
        // This is custom for this cell because the normal behavior for checking
        // cell selection is consumed by the text view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(ResourceCollectionViewCell.selectCell(_:)))
        self.addGestureRecognizer(tap)
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helper functions
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        // Force the text in a UITextView to always center itself.
        let textView = object as! UITextView
        var topCorrect = (textView.bounds.size.height - textView.contentSize.height * textView.zoomScale) / 2
        topCorrect = topCorrect < 0.0 ? 0.0 : topCorrect;
        textView.contentInset.top = topCorrect
    }
    
    func selectCell(_ tap: UITapGestureRecognizer) {
        if delegate != nil {
            delegate?.didSelect(sender: self)
        }
    }
}
