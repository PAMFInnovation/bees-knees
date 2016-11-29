//
//  ProfileViewController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 10/26/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit


protocol ProfileDelegate: class {
    func profileNextButtonPressed(sender: ProfileViewController)
}

class ProfileViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var fullNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var nextButton: HighlightButton!
    @IBOutlet weak var profileIcon: UIImageView!
    
    // Next button delegate
    weak var delegate: ProfileDelegate?
    
    // Keep track of the observed UI item in case we need to make it visible via scrolling
    var activeElement: UIControl?
    
    // Keep default edge insets for when we need to reset scrolling
    var contentSize: CGSize?
    var defaultScrollInsets: UIEdgeInsets?
    
    
    // MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init() {
        self.init(nibName: "ProfileInterface", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set text fields using data stored in ProfileManager singleton
        fullNameField.text = ProfileManager.sharedInstance.name
        emailField.text = ProfileManager.sharedInstance.email
        phoneField.text = ProfileManager.sharedInstance.phone
        
        // Set the color of the icon
        profileIcon.image = profileIcon.image?.withRenderingMode(.alwaysTemplate)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // TODO: is there a better way to handle this? Wrapper?
        // Show the button if we have a delegate
        if delegate != nil {
            nextButton.isHidden = false
        }
        
        // Listen to keyboard events so we can reposition scroll items
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardOnScreen), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        center.addObserver(self, selector: #selector(keyboardOffScreen), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Set the initial scroll view size and insets
        // Here, we need to set the content size of the scroll view
        // to be the aggregate of ALL bounds in the subviews.
        // There is only one subview in the scrollview, but we need
        // that scroll view's combined bounds.
        // Other observations: need to resize the height of the subview
        // in order to retain the hit box such that we can tap on every
        // element. This last point is important because without doing
        // that, the button at the bottom was not interactive.
        var subviewRect = CGRect.zero
        for _view in scrollView.subviews[0].subviews {
            subviewRect = subviewRect.union(_view.frame)
        }
        contentSize = subviewRect.size
        defaultScrollInsets = scrollView.contentInset
        
        // Update the scroll view's content boundaries
        scrollView.contentSize = contentSize!
        scrollView.contentInset = defaultScrollInsets!
        scrollView.scrollIndicatorInsets = defaultScrollInsets!
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Save the profile data
        ProfileManager.sharedInstance.name = fullNameField.text!
        ProfileManager.sharedInstance.email = emailField.text!
        ProfileManager.sharedInstance.phone = phoneField.text!
        
        // Unregister from keyboard events
        let center = NotificationCenter.default
        center.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        center.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    // MARK: - UI buttons
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        // Close the keyboard for good measure
        self.view.endEditing(true)
        
        // Trigger the delegate
        delegate?.profileNextButtonPressed(sender: self)
    }
    
    
    // MARK: - Keyboard events
    public func keyboardOnScreen(notification: NSNotification) {
        // Get the keyboard rectangle so we can offset our scroll view by its size
        let info: NSDictionary = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIKeyboardFrameBeginUserInfoKey) as? NSValue)?.cgRectValue.size
        
        // Set the content insets of the scroll view using the keyboard's height
        var contentInsets:UIEdgeInsets = defaultScrollInsets!
        contentInsets.bottom += kbSize!.height
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
    }
    
    public func keyboardOffScreen(notification: NSNotification) {
        // Reset the scroll view insets and content size
        scrollView.contentSize = contentSize!
        scrollView.contentInset = defaultScrollInsets!
        scrollView.scrollIndicatorInsets = defaultScrollInsets!
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
