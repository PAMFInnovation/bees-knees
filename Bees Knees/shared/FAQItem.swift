//
//  FAQItem.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/16/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import Foundation
import UIKit


class FAQItem: NSObject {
    
    var question: String!
    var answer: String!
    var expanded: Bool!
    var height: CGFloat = 60
    
    
    init(question: String, answer: String) {
        self.question = question
        self.answer = answer
        self.expanded = false
    }
}
