//
//  ResourceViewController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 1/19/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import UIKit


class ResourceViewController: UIViewController {
    
    // MARK: - Properties
    var scrollView: UIScrollView!
    var defaultScrollInsets: UIEdgeInsets?  // keep default edge insets for when we need to reset scrolling
    
    
    // MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // White background color
        self.view.backgroundColor = UIColor.white
        
        // Setup the scrollview
        self.scrollView = UIScrollView(frame: self.view.frame)
        self.view.addSubview(scrollView)
        
        // Setup the title
        let title = UILabel(frame: CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.width, height: 60))
        title.text = "My Title"
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 24)
        title.textColor = UIColor.black
        self.scrollView.addSubview(title)
        
        // Setup the text view
        let textView = UITextView(frame: CGRect(x: self.view.frame.origin.x + 20, y: self.view.frame.origin.y + 60, width: self.view.frame.width - 40, height: self.view.frame.height - 60))
        //textView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20)
        textView.textAlignment = .left
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.textColor = UIColor.black
        textView.isSelectable = false
        textView.isEditable = false
        self.scrollView.addSubview(textView)
        
        // Sample text
        let attrStr = try! NSMutableAttributedString(
            data: "This <i>paragraph</i> contains a lot of lines in the source code, but the browser ignores it.<p>This paragraph contains a lot of spaces in the source     code, but the    browserignores it.</p><p>The number of lines in a paragraph depends on the size of the browser window. If you resize the browser window, the number of lines in this paragraph will change.</p><p>This <b>paragraph</b> contains a lot of lines in the source code, but the browser ignores it.</p><p>This paragraph contains a lot of spaces in the source     code, but the    browserignores it.</p><p>The number of lines in a paragraph depends on the size of the browser window. If you resize the browser window, the number of lines in this paragraph will change.</p><p>This paragraph contains a lot of lines in the source code, but the browser ignores it.</p><p>This paragraph contains a lot of spaces in the source     code, but the    browserignores it.</p><p>The number of lines in a paragraph depends on the size of the browser window. If you resize the browser window, the number of lines in this paragraph will change.</p><p>This paragraph contains a lot of lines in the source code, but the browser ignores it.</p><p>This paragraph contains a lot of spaces in the source     code, but the    browserignores it.</p><p>The number of lines in a paragraph depends on the size of the browser window. If you resize the browser window, the number of lines in this paragraph will change.</p>".data(using: String.Encoding.unicode, allowLossyConversion: true)!,
            options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
            documentAttributes: nil)
        attrStr.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 18), range: NSRange(location: 0, length: attrStr.length))
        textView.attributedText = attrStr
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Set default scroll insets
        defaultScrollInsets = scrollView.contentInset
    }
}
