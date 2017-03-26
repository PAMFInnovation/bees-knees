//
//  GlossModel.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 3/25/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import Gloss


protocol GlossModel {
    init(json: JSON)
    func toJSON() -> JSON?
}
