//
//  UIView+RoundCorners.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 1/24/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import UIKit


extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
