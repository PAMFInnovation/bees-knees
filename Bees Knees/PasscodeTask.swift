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
    welcomeStep.text = "Please create a personal 4-digit passcode. This helps us keep your information secure. Every time you log into the app, you will be asked to enter your 4-digit passcode."
    steps += [welcomeStep]
    
    let passcodeStep = ORKPasscodeStep(identifier: "passcodeStep");
    passcodeStep.passcodeType = ORKPasscodeType.type4Digit;
    steps += [passcodeStep];
    
    let summaryStep = ORKCompletionStep(identifier: "summaryStep")
    summaryStep.title = "Thank you!"
    summaryStep.text = "Your security passcode is set, and your account is secured. Let's get started on your care!\n\nRemember, you can always change your passcode at any time."
    steps += [summaryStep]
    
    return ORKOrderedTask(identifier: "PasscodeTask", steps: steps)
}
