//
//  Resource.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/15/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import Foundation


enum ResourceType {
    case DOC
    case IMAGE
    case VIDEO
}

class Resource: NSObject {
    
    var type: ResourceType!
    var title: String!
    var fileName: String!
    var fileType: String!
    
    
    
    init(type: ResourceType, title: String, fileName: String, fileType: String) {
        self.type = type
        self.title = title
        self.fileName = fileName
        self.fileType = fileType
    }
}
