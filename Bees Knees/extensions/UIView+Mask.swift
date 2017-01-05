//
//  UIView+Mask.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 12/29/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit


extension UIView {
    func mask(withRect rect: CGRect, inverse: Bool = false) {
        let path = UIBezierPath(rect: rect)
        let maskLayer = CAShapeLayer()
        
        if inverse {
            path.append(UIBezierPath(rect: self.bounds))
            maskLayer.fillRule = kCAFillRuleEvenOdd
        }
        
        maskLayer.path = path.cgPath
        
        self.layer.mask = maskLayer
    }
    
    func mask(withPath path: UIBezierPath, inverse: Bool = false) -> CAShapeLayer {
        let path = path
        let maskLayer = CAShapeLayer()
        
        if inverse {
            path.append(UIBezierPath(rect: self.bounds))
            maskLayer.fillRule = kCAFillRuleEvenOdd
        }
        
        maskLayer.path = path.cgPath
        
        self.layer.mask = maskLayer
        
        /*let shape = CAShapeLayer()
        shape.frame = self.bounds
        shape.path = path.cgPath
        shape.lineWidth = 3.0
        shape.strokeColor = Colors.turquoise.color.cgColor
        shape.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(shape)*/
        
        return maskLayer
    }
}
