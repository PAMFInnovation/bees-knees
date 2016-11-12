//
//  LinePath.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/11/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit


class MyPath: UIView {
    
    var path = UIBezierPath()
    
    var start: CGPoint = CGPoint()
    var end: CGPoint = CGPoint()
    
    var isDashed: Bool = false
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
    }
    
    convenience init(frame: CGRect, isDashed: Bool) {
        self.init(frame: frame)
        
        self.isDashed = isDashed
    }
    
    convenience init(frame: CGRect, isDashed: Bool, start: CGPoint, end: CGPoint) {
        self.init(frame: frame, isDashed: isDashed)
        
        self.start = start
        self.end = end
    }
    
    override func draw(_ rect: CGRect) {
        // Create the bezier path
        path.removeAllPoints()
        path.move(to: start)
        path.addLine(to: end)
        path.lineWidth = 6
        
        // Set dashes if necessary
        if isDashed {
            let dashes: [CGFloat] = [path.lineWidth * 0, path.lineWidth * 2]
            path.setLineDash(dashes, count: dashes.count, phase: 0)
            path.lineCapStyle = .round
        }
        
        // Color the line
        //UIColor.red.set()
        Colors.turquoise.color.set()
        path.stroke()
        path.close()
    }
    
    func setStartPoint(_ point: CGPoint) {
        start = point
    }
    
    func setEndPoint(_ point: CGPoint) {
        end = point
    }
}
