//
//  PasscodeTask.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 9/9/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import ResearchKit

public var PasscodeTask: ORKOrderedTask {
    var steps = [ORKStep]()
    
    let welcomeStep = ORKInstructionStep(identifier: "welcomeStep")
    welcomeStep.title = "Bees Knees"
    welcomeStep.text = "Before we begin, we ask that you set a passcode for when you need to view sensitive data. This passcode will be tracked specifically for this app."
    steps += [welcomeStep]
    
    let passcodeStep = ORKPasscodeStep(identifier: "passcodeStep");
    passcodeStep.passcodeType = ORKPasscodeType.Type6Digit;
    steps += [passcodeStep];
    
    let summaryStep = ORKCompletionStep(identifier: "summaryStep")
    summaryStep.title = "Thank you!"
    summaryStep.text = "Your passcode is now set so let's get started with your care. Remember, you can always change your passcode at any time."
    steps += [summaryStep]
    
    return ORKOrderedTask(identifier: "PasscodeTask", steps: steps)
}