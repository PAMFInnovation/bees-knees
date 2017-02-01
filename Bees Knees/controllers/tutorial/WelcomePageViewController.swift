//
//  WelcomePageViewController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 1/2/17.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit


protocol WelcomePageViewControllerDelegate: class {
    func completeWelcome(sender: WelcomePageViewController)
}

class WelcomePageViewController: UIPageViewController {
    
    weak var classDelegate: WelcomePageViewControllerDelegate?
    
    var orderedViewControllers: [UIViewController] = []
    var currentIndex: Int = 0
    
    // The main view to cover the screen, mask, and attach subviews to
    var mainView: UIView = UIView()
    
    
    // MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Flat background color
        //self.view.backgroundColor = Colors.turquoise.color
        // Gradient background color
        //self.view.backgroundColor = UIColor.clear
        let gradient = CAGradientLayer()
        gradient.frame = self.view.bounds
        gradient.colors = [Colors.turquoiseLight1.color.cgColor, Colors.turquoise.color.cgColor]
        //gradient.colors = [Colors.turquoise.color.cgColor, UIColor.white.cgColor]
        view.layer.insertSublayer(gradient, at: 0)
        
        // Add the view controllers
        let welcome1 = WelcomeTextViewController(text: "Welcome to\nBee's Knees!", fontSize: 38)
        welcome1.shouldDisplaySwipeTip = true
        orderedViewControllers.append(welcome1)
        let welcome2 = WelcomeTextViewController(text: "This App will help you prepare for your upcoming surgery and support your recovery.", fontSize: 28)
        welcome2.shouldDisplaySwipeTip = true
        orderedViewControllers.append(welcome2)
        let welcome3 = WelcomeTextViewController(text: "Bee's Knees is a personalized journal and navigational guide on your road to recovery.", fontSize: 28)
        welcome3.shouldDisplaySwipeTip = true
        orderedViewControllers.append(welcome3)
        let terms = WelcomeTACController(text: "Before we get started, we'd like to review the terms and conditions.", fontSize: 28)
        terms.delegate = self
        orderedViewControllers.append(terms)
        let passcode = WelcomePasscodeViewController(text: "You can also keep your information secure by setting a 4-digit passcode. You will be asked to enter your passcode when you open this app.", fontSize: 28)
        passcode.delegate = self
        orderedViewControllers.append(passcode)
        let date = WelcomeDateViewController(text: "If you know when your surgery is scheduled, you can enter the date here.", fontSize: 28)
        date.delegate = self
        orderedViewControllers.append(date)
        let transition = WelcomeTransitionViewController(text: "You're all set and ready to get started with your routine.", fontSize: 28)
        transition.delegate = self
        orderedViewControllers.append(transition)
        
        /*// Add the background image
        let imageView = UIImageView(frame: self.view.frame)
        imageView.image = UIImage(named: "background-image")
        mainView.addSubview(imageView)
        
        // Setup the view
        mainView.frame = self.view.frame
        mainView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            mainView.backgroundColor = UIColor.clear
            
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
        
        self.view.insertSubview(mainView, at: 0)*/
        
        // Set the data source
        self.dataSource = self
        
        // Set the first view controller
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    
    // MARK: - Helper functions
    private func testViewController(_ color: UIColor) -> UIViewController {
        let vc: UIViewController = UIViewController()
        vc.view.backgroundColor = color
        return vc
    }
    
    func goToViewControllerAtIndex(_ index: Int) {
        currentIndex = index
        setViewControllers([orderedViewControllers[currentIndex]], direction: .forward, animated: true, completion: nil)
    }
    
    func dismissSelf() {
        UIView.animate(withDuration: 1.0, animations: {
            self.view.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
        }, completion: { _ in
            self.view.removeFromSuperview()
            self.removeFromParentViewController()
        })
    }
}


// MARK: - Page View Controller Data Source
extension WelcomePageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllersCount - 1 > previousIndex else {
            return nil
        }
        
        currentIndex = previousIndex
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard nextIndex != orderedViewControllersCount else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        if orderedViewControllers[nextIndex] is WelcomePasscodeViewController &&
            ProfileManager.sharedInstance.getSignedConsentDocument() == nil {
            return nil
        }
        
        currentIndex = nextIndex
        return orderedViewControllers[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentIndex
    }
}

extension WelcomePageViewController: WelcomeTACControllerDelegate {
    func completeTerms(sender: WelcomeTACController) {
        self.goToViewControllerAtIndex(4)
    }
}

extension WelcomePageViewController: WelcomePasscodeViewControllerDelegate {
    func completeOrSkipPasscode(sender: WelcomePasscodeViewController) {
        self.goToViewControllerAtIndex(5)
    }
}

extension WelcomePageViewController: WelcomeDateViewControllerDelegate {
    func completeOrSkipDate(sender: WelcomeDateViewController) {
        self.goToViewControllerAtIndex(6)
    }
}

extension WelcomePageViewController: WelcomeTransitionViewControllerDelegate {
    func transition(sender: WelcomeTransitionViewController) {
        self.classDelegate?.completeWelcome(sender: self)
    }
}
