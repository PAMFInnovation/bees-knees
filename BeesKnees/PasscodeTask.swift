//
//  PasscodeTask.swift
//  BeesKnees
//
//  Created by Ben Dapkiewicz on 9/9/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import ResearchKit

public var PasscodeTask: ORKOrderedTask {
    var steps = [ORKStep]()
    
    let passcodeStep = ORKPasscodeStep(identifier: "passcodeStep");
    passcodeStep.passcodeType = ORKPasscodeType.Type6Digit;
    steps += [passcodeStep];
    
    return ORKOrderedTask(identifier: "PasscodeTask", steps: steps)
}