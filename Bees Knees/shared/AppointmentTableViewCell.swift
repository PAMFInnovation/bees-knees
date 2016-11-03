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
    var labelText: String!
    var labelHeight: CGFloat! // label position should always be the same if expanded
    
    // State indicates if this cell can be expanded
    var canExpand: Bool = false
    
    // State indicates if the cell is expanded
    var isExpanded: Bool = false
    
    // Expanded height value
    var expandedHeight: CGFloat = 144
    
    
    // MARK: - Initialization
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // No selection style
        self.selectionStyle = .none
        
        // Set default label text
        labelText = ""
        
        // Set the label height
        labelHeight = self.frame.height
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let labelOffset: CGFloat = 15
        let labelWidth: CGFloat = 60
        
        // Add the label
        label.frame = CGRect(x: labelOffset, y: 0, width: labelWidth, height: labelHeight)
        label.text = labelText
        label.textColor = UIColor.red
        self.addSubview(label)
    }
}
