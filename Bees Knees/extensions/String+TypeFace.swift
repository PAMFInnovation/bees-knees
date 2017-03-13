//
//  String+TypeFace.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 3/13/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import UIKit


extension String {
    func withBoldText(boldPartsOfString: Array<NSString>, font: UIFont!, boldFont: UIFont!, alignment: NSTextAlignment = .left) -> NSAttributedString {
        let style = NSMutableParagraphStyle()
        style.alignment = alignment
        let boldFontAttribute = [NSFontAttributeName:boldFont!]
        let boldString = NSMutableAttributedString(string: self as String, attributes:[NSFontAttributeName:font!, NSParagraphStyleAttributeName: style])
        for i in 0 ..< boldPartsOfString.count {
            boldString.addAttributes(boldFontAttribute, range: (self as NSString).range(of: boldPartsOfString[i] as String))
        }
        return boldString
    }
}
