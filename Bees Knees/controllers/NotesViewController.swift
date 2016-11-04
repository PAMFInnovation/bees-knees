//
//  NotesViewController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/4/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit


class NotesViewController: UIViewController, UITextViewDelegate {
    
    // Label subview for placeholder text
    var label = UILabel()
    
    // Text Area subview
    var textArea = UITextView()
    var defaultInsets: UIEdgeInsets?
    
    
    // MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add a text area
        textArea.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        textArea.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textArea.font = UIFont(name: "ArialMT", size: 18)
        textArea.isScrollEnabled = true
        textArea.layoutManager.allowsNonContiguousLayout = false
        textArea.keyboardDismissMode = .interactive
        textArea.contentInset = .zero
        textArea.scrollIndicatorInsets = .zero
        textArea.delegate = self
        self.view.addSubview(textArea)
        
        // Load the notes
        textArea.text = ProfileManager.sharedInstance.notes
        
        // Add the placeholder label
        label.frame = CGRect(x: 10, y: 60, width: self.view.frame.width, height: 50)
        label.text = "Tap here to edit notes..."
        label.textColor = UIColor.lightGray
        label.font = UIFont(name: "Arial-ItalicMT", size: 18)
        self.view.addSubview(label)
        
        // If there are notes, hide the label
        if textArea.text != "" {
            label.isHidden = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Listen to keyboard events so we can reposition scroll items
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardOnScreen), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        center.addObserver(self, selector: #selector(keyboardOffScreen), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Unregister from keyboard events
        let center = NotificationCenter.default
        center.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        center.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        // Save the notes
        ProfileManager.sharedInstance.notes = textArea.text
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        defaultInsets = textArea.contentInset
    }
    
    
    // MARK: - Keyboard events
    public func keyboardOnScreen(notification: NSNotification) {
        // Position the insets to account for the keyboard
        let userData = notification.userInfo!
        var rect = userData[UIKeyboardFrameEndUserInfoKey] as! CGRect
        rect = textArea.convert(rect, from: nil)
        textArea.contentInset.bottom = rect.size.height
        textArea.scrollIndicatorInsets.bottom = rect.size.height
    }
    
    public func keyboardOffScreen(notification: NSNotification) {
        // Reset the text area to its default insets
        textArea.contentInset = defaultInsets!
        textArea.scrollIndicatorInsets = defaultInsets!
    }
    
    
    // MARK: - Text View Delegate
    func textViewDidChange(_ textView: UITextView) {
        // Show or hide the placeholder label
        label.isHidden = textView.text == "" ? false : true
    }
}
