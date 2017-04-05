//
//  ConsentTask.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 8/25/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import ResearchKit

public var ConsentTask: ORKOrderedTask {
    var steps = [ORKStep]()
    
    let consentDocument = ConsentDocument
    let visualConsentStep = ORKVisualConsentStep(identifier: "VisualConsentStep", document: consentDocument)
    //steps += [visualConsentStep]
    
    //let signature = consentDocument.signatures!.first! as ORKConsentSignature
    
    //let reviewConsentStep = ORKConsentReviewStep(identifier: "ConsentReviewStep", signature: signature, in: consentDocument)
    let reviewConsentStep = ORKConsentReviewStep(identifier: "ConsentReviewStep", signature: nil, in: consentDocument)
    //reviewConsentStep.
    
    reviewConsentStep.text = "Review Consent!"
    reviewConsentStep.reasonForConsent = "I agree to these terms"
    
    steps += [reviewConsentStep]
    
    return ORKOrderedTask(identifier: "ConsentTask", steps: steps)
}
