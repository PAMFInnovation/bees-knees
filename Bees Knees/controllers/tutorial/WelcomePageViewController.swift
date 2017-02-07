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
        gradient.colors = [Colors.turquoiseLight2.color.cgColor, Colors.turquoise.color.cgColor]
        //gradient.colors = [Colors.turquoise.color.cgColor, UIColor.white.cgColor]
        view.layer.insertSublayer(gradient, at: 0)
        
        // Add the view controllers
        let welcome1 = WelcomeTaskViewController(mainText: "Welcome to JointCare!", secondaryText: "Helping prepare you for surgery and support your recovery", mainFontSize: 32, secondaryFontSize: 22, icon: "blank-icon", displaySwipeTip: true)
        orderedViewControllers.append(welcome1)
        let welcome2 = WelcomeInstructionsViewController()
        orderedViewControllers.append(welcome2)
        let terms = WelcomeTACController(mainText: "Before we get started, let's review terms of use.", secondaryText: "Please note: this app is just for you! The info in this app will not be available to your care team. Feel free to share the app with your care team at any visit.", mainFontSize: 22, secondaryFontSize: 16, icon: "welcome_legal")
        terms.delegate = self
        orderedViewControllers.append(terms)
        let passcode = WelcomePasscodeViewController(mainText: "Next step is to set up an optional passcode to secure your information.", secondaryText: "You'll enter your passcode when you open this app, and you can change your passcode at any time.", mainFontSize: 22, secondaryFontSize: 16, icon: "welcome_passcode")
        passcode.delegate = self
        orderedViewControllers.append(passcode)
        let date = WelcomeDateViewController(mainText: "One more thing! Set your surgery date so the app can help keep you on track.", secondaryText: "Don't worry -- if you don't know your surgery date, you can add that later.", mainFontSize: 22, secondaryFontSize: 16, icon: "welcome_date")
        date.delegate = self
        orderedViewControllers.append(date)
        let transition = WelcomeTransitionViewController(mainText: "You're all set! Now let's get started with your routine.", secondaryText: "On the next page, you can add all your appointments and what's ahead.\n\nThen, explore all the tabs along the bottom for more helpful tools, like \"Activities\" for exercises, and \"More\" for the binder.", mainFontSize: 22, secondaryFontSize: 16, icon: "welcome_done")
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
        currentIndex = viewControllerIndex
        
        let previousIndex = viewControllerIndex - 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllersCount - 1 > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        currentIndex = viewControllerIndex
        
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
        
        return orderedViewControllers[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentIndex
    }
}

extension WelcomePageViewController: WelcomeTaskViewControllerDelegate {
    func completeTask(sender: WelcomeTaskViewController) {
        if sender is WelcomeTransitionViewController {
            self.classDelegate?.completeWelcome(sender: self)
        }
        else {
            if sender is WelcomeTACController {
                self.goToViewControllerAtIndex(3)
            }
            else if sender is WelcomePasscodeViewController {
                self.goToViewControllerAtIndex(4)
            }
            else if sender is WelcomeDateViewController {
                self.goToViewControllerAtIndex(5)
            }
        }
    }
}
