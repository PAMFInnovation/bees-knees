//
//  TutorialViewController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 12/30/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit


enum TutorialStep {
    case WelcomeText1
    case WelcomeText2
    case WelcomeText3
}


class TutorialViewController: UIViewController {
    
    // Current tutorial step
    var step: TutorialStep = .WelcomeText1
    var panWidth: CGFloat = 150
    
    // The main view to cover the screen, mask, and attach subviews to
    var mainView: UIView = UIView()
    
    // Text to display
    var textView: UITextView = UITextView()
    
    // Tutorial views
    var welcome1View: UIView = UIView()
    var welcome2View: UIView = UIView()
    var welcome3View: UIView = UIView()
    
    
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
        
        // Add the background image
        /*let imageView = UIImageView(frame: self.view.frame)
        imageView.image = UIImage(named: "background-image")
        mainView.addSubview(imageView)*/
        
        // Setup the view
        mainView.frame = self.view.frame
        mainView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            //mainView.backgroundColor = UIColor.clear
            
            let blurEffect = UIBlurEffect(style: .light)
            
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            
            // Always fill the view
            blurEffectView.frame = self.view.frame
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            mainView.addSubview(blurEffectView)
        }
        else {
            mainView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.9)
        }
        
        mainView.isUserInteractionEnabled = true
        
        // Attach to view
        self.view = mainView
        
        // Add the tutorials views
        //self.view.addSubview(welcome1View)
        //self.view.addSubview(welcome2View)
        //self.view.addSubview(welcome3View)
        
        // Setup the text view
        textView.frame = CGRect(x: 0, y: 200, width: self.view.frame.width, height: 200)
        textView.font = UIFont.systemFont(ofSize: 34, weight: UIFontWeightLight)
        textView.textColor = UIColor.white
        textView.backgroundColor = UIColor.clear
        textView.textAlignment = .center
        textView.text = ""
        textView.isEditable = false
        textView.isSelectable = false
        textView.layer.shadowOpacity = 1.0
        textView.layer.shadowRadius = 0.0
        textView.layer.shadowColor = UIColor.black.cgColor
        textView.layer.shadowOffset = CGSize(width: 1, height: 1)
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        // Attach the text
        welcome1View.addSubview(textView)
        
        /*self.view.addConstraint(NSLayoutConstraint(item: textView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: textView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: textView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: self.view.frame.width))
        self.view.addConstraint(NSLayoutConstraint(item: textView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 200))*/
        
        // Pan gesture
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.responseToPanGesture))
        self.view.addGestureRecognizer(panRecognizer)
        panWidth = self.view.frame.width / 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        // TESTING
        animateSpotlight(fromPath: UIBezierPath(roundedRect: CGRect(x: 70, y: 70, width: 1, height: 1), cornerRadius: 5), toPath: UIBezierPath(roundedRect: CGRect(x: 20, y: 20, width: 100, height: 100), cornerRadius: 50), duration: 0.5, delay: 3)
        
        animateSpotlight(fromPath: UIBezierPath(roundedRect: CGRect(x: 20, y: 20, width: 100, height: 100), cornerRadius: 50), toPath: UIBezierPath(roundedRect: CGRect(x: 100, y: 100, width: 200, height: 60), cornerRadius: 5), duration: 0.5, delay: 8)
        
        animateSpotlight(fromPath: UIBezierPath(roundedRect: CGRect(x: 100, y: 100, width: 200, height: 60), cornerRadius: 5), toPath: UIBezierPath(roundedRect: CGRect(x: 100, y: 100, width: 200, height: 200), cornerRadius: 100), duration: 0.5, delay: 15)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    
    // MARK: - Helper functions
    func animateSpotlight(fromPath: UIBezierPath, toPath: UIBezierPath, duration: CFTimeInterval, delay: CFTimeInterval) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
            // Mask the view with the from-path
            let maskLayer = self.view.mask(withPath: fromPath, inverse: true)
            
            // Create a mask to animate to
            toPath.append(UIBezierPath(rect: self.view.bounds))
            
            // Create the animation with from-mask to to-mask
            let anim = CABasicAnimation(keyPath: "path")
            anim.fromValue = maskLayer.path
            anim.toValue = toPath.cgPath
            anim.duration = duration
            anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
            
            // Add the animation to the from-mask
            maskLayer.add(anim, forKey: nil)
            
            // Begin the animation transaction
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            maskLayer.path = toPath.cgPath
            CATransaction.commit()
        })
    }
    
    func responseToPanGesture(gesture: UIPanGestureRecognizer) {
        if gesture.state == .began || gesture.state == .changed {
            let translation = gesture.translation(in: self.view)
            print(translation)
            
            let newPos = CGPoint(x: translation.x, y: 0)
            welcome1View.frame.origin = newPos
            
            /*// note: 'view' is optional and need to be unwrapped
            gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x + translation.x, y: gestureRecognizer.view!.center.y + translation.y)
            gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)*/
        }
    }
}
