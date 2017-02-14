//
//  PostWelcomePageViewController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 2/14/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import UIKit


protocol PostWelcomePageViewControllerDelegate: class {
    func postWelcomeComplete(sender: PostWelcomePageViewController)
    func postWelcomeReturn(sender: PostWelcomePageViewController)
}

class PostWelcomePageViewController: UIPageViewController {
    
    var orderedViewControllers: [UIViewController] = []
    var currentIndex: Int = 0
    
    // Class delegate
    weak var classDelegate: PostWelcomePageViewControllerDelegate?
    
    
    // MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Gradient background color
        let gradient = CAGradientLayer()
        gradient.frame = self.view.bounds
        gradient.colors = [UIColor.init("#00c0ba").cgColor, UIColor.init("#005d58").cgColor]
        view.layer.insertSublayer(gradient, at: 0)
        
        // Add the view controllers
        let confirm = PostWelcomeConfirmViewController(mainText: "Had surgery?", secondaryText: "According to the app, your surgery date has passed. If you have had surgery, please confirm by tapping 'Continue' below.\n\nIf you haven't had your surgery, please update the surgery date to keep preparing.", mainFontSize: 22, secondaryFontSize: 16, icon: "post_confirm")
        confirm.delegate = self
        confirm.classDelegate = self
        orderedViewControllers.append(confirm)
        let transition = WelcomeTransitionViewController(mainText: "Congratulations!", secondaryText: "Surgery is a big step, and you did it! Now, it's time to keep making progress with your recovery.\n\nMake sure to check out a new feature: 'Progress Tracker and History' where you can record pain and monitor how that changes over time.", mainFontSize: 22, secondaryFontSize: 16, icon: "post_congrats")
        transition.delegate = self
        orderedViewControllers.append(transition)
        
        // Set the data source
        self.dataSource = self
        
        // Set the first view controller
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    // MARK: - Helper functions
    func goToViewControllerAtIndex(_ index: Int) {
        currentIndex = index
        setViewControllers([orderedViewControllers[currentIndex]], direction: .forward, animated: true, completion: nil)
    }
}


// MARK: - Page View Controller Data Source
extension PostWelcomePageViewController: UIPageViewControllerDataSource {
    
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
        
        return orderedViewControllers[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentIndex
    }
}

extension PostWelcomePageViewController: WelcomeTaskViewControllerDelegate {
    func completeTask(sender: WelcomeTaskViewController) {
        if sender is WelcomeTransitionViewController {
            // Add the DailyRoutine assessment to the care store, since it needs to occur on a specific day
            ProfileManager.sharedInstance.setPostSurgeryStartDate(Date())
            CarePlanStoreManager.sharedInstance.addDailyRoutineAssessment()
            
            // Complete this flow
            self.classDelegate?.postWelcomeComplete(sender: self)
        }
        else if sender is PostWelcomeConfirmViewController {
            self.goToViewControllerAtIndex(1)
        }
    }
}

extension PostWelcomePageViewController: PostWelcomeConfirmViewControllerDelegate {
    func closePostWelcomeFlow() {
        self.classDelegate?.postWelcomeReturn(sender: self)
    }
}
