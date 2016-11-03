//
//  AppointmentTableViewCell
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/2/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit


class AppointmentTableViewCell: UITableViewCell {
    
    // Label
    var label = UILabel()
    var labelHeight: CGFloat! // label position should always be the same if expanded
    
    // State indicates if this cell can be expanded
    var canExpand: Bool = false
    
    // State indicates if the cell is expanded
    var isExpanded: Bool = false
    
    // Height values
    var defaultHeight: CGFloat = 44
    var expandedHeight: CGFloat = 44
    
    
    // MARK: - Initialization
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // No selection style
        self.selectionStyle = .none
        
        // Set content clipping
        self.autoresizingMask = .flexibleHeight
        self.clipsToBounds = true
        
        // Set the label height and offsets
        labelHeight = self.frame.height
        let labelOffset: CGFloat = 15
        let labelWidth: CGFloat = 60
        
        // Add the label
        label.frame = CGRect(x: labelOffset, y: 0, width: labelWidth, height: labelHeight)
        label.textColor = UIColor.red
        self.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
