//
//  WelcomePageViewController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 1/2/17.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit


class WelcomePageViewController: UIPageViewController {
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [
            WelcomeTextViewController(text: "Welcome to\nBee's Knees!", fontSize: 38),
            WelcomeTextViewController(text: "This App will help you prepare for your upcoming surgery and support your recovery.", fontSize: 28),
            WelcomeTextViewController(text: "Bee's Knees is a personalized journal and navigational guide on your road to recovery.", fontSize: 28),
            WelcomeTACController(text: "Before we get started, we'd like to review the terms and conditions.", fontSize: 28),
            UIViewController()
        ]
    }()
    
    // The main view to cover the screen, mask, and attach subviews to
    var mainView: UIView = UIView()
    
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add the background image
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
        
        self.view.insertSubview(mainView, at: 0)
        
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
        
        return orderedViewControllers[nextIndex]
    }
}
