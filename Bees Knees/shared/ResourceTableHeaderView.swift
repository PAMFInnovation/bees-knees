//
//  ResourceTableHeaderView.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 2/5/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import UIKit


class ResourceTableHeaderView: UIView {
    
    // MARK: - Properties
    var title = UILabel()
    
    
    // MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        // Set the background color
        self.backgroundColor = UIColor("#F0EFF5")
        
        // Add the title view
        title.frame = self.bounds
        title.frame.origin.x = 15.0
        title.font = UIFont.systemFont(ofSize: 16)
        title.textAlignment = .left
        title.textColor = UIColor.gray
        self.addSubview(title)
    }
}
