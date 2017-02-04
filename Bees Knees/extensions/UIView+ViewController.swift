//
//  UIView+ViewController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 2/3/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import UIKit


extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
