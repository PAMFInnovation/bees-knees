//
//  ProfileViewController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 10/26/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit


protocol ProfileNextDelegate: class {
    func profileNextButtonPressed(sender: ProfileViewController)
}

class ProfileViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var keyboardDoneButton: UIButton!
    @IBOutlet weak var fullNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    
    // Next button delegate
    weak var delegate: ProfileNextDelegate?
    
    // Keep track of the observed UI item in case we need to make it visible via scrolling
    var activeElement: UIControl?
    
    
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
        
        // Set text fields using data stored in ProfileManager singleton
        fullNameField.text = ProfileManager.sharedInstance.name
        emailField.text = ProfileManager.sharedInstance.email
        phoneField.text = ProfileManager.sharedInstance.phone
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Listen to keyboard events so we can reposition scroll items
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardOnScreen), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        center.addObserver(self, selector: #selector(keyboardOffScreen), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        // Only show the keyboard done button when the keyboard is enabled
        self.hideKeyboardDoneButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Unregister from keyboard events
        let center = NotificationCenter.default
        center.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        center.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    
    // MARK: - Helper functions
    func showKeyboardDoneButton() {
        keyboardDoneButton.isHidden = false
    }
    
    func hideKeyboardDoneButton() {
        keyboardDoneButton.isHidden = true
    }
    
    
    // MARK: - UI buttons
    @IBAction func closeKeyboard(_ sender: UIButton) {
        self.view.endEditing(true)
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        // Close the keyboard for good measure
        self.view.endEditing(true)
        
        // Save the profile data
        ProfileManager.sharedInstance.name = fullNameField.text!
        ProfileManager.sharedInstance.email = emailField.text!
        ProfileManager.sharedInstance.phone = phoneField.text!
        
        // Trigger the delegate
        delegate?.profileNextButtonPressed(sender: self)
    }
    
    
    // MARK: - Keyboard events
    public func keyboardOnScreen(notification: NSNotification) {
        // Get the keyboard rectangle so we can offset our scroll view by its size
        let info: NSDictionary = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIKeyboardFrameBeginUserInfoKey) as? NSValue)?.cgRectValue.size
        
        // Set the content insets of the scroll view using the keyboard's height
        let contentInsets:UIEdgeInsets  = UIEdgeInsetsMake(0.0, 0.0, kbSize!.height, 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        
        //--- If the text area collides with the keyboard, we need to move it in view ---//
        // Get the bounds of the view that we can see, excluding the space occupied by the keyboard
        var aRect: CGRect = UIScreen.main.bounds
        aRect.size.height -= (kbSize?.height)!
        
        // Convert the text view's center to the root view's coordinate system
        // We need to do this because we are checking the absolute position of
        // the text area against the screen bounds
        let textAreaCenter: CGPoint = CGPoint(x: (self.activeElement?.frame.midX)!, y: (self.activeElement?.frame.midY)!)
        let convertedPoint: CGPoint = (self.activeElement?.superview?.convert(textAreaCenter, to: self.view))!
        
        // If the visible space does not contain the converted point, we need to scroll it in view
        if (!aRect.contains(convertedPoint)) {
            let scrollPoint:CGPoint = CGPoint(x: 0.0, y: self.scrollView.contentOffset.y + convertedPoint.y - kbSize!.height)
            self.scrollView.setContentOffset(scrollPoint, animated: true)
        }
        
        // Show the keyboard done button
        self.showKeyboardDoneButton()
    }
    
    public func keyboardOffScreen(notification: NSNotification) {
        // Reset the scroll view insets
        let contentInsets:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
        // Hide the keyboard done button
        self.hideKeyboardDoneButton()
    }
    
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        activeElement = textField
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
