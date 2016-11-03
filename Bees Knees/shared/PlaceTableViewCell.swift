//
//  PlaceTableViewCell.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/2/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit


class PlaceTableViewCell: AppointmentTableViewCell {
    
    // MARK: - Initialization
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // No selection style
        self.selectionStyle = .none
        
        // Set label text
        self.label.text = "Where"
        
        // This cell can expand
        canExpand = true
        expandedHeight = 144
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
