//
//  ConsentDocument.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 8/25/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import ResearchKit

public var ConsentDocument: ORKConsentDocument {
    let consentDocument = ORKConsentDocument()
    consentDocument.title = "Example Consent"
    
    let consentSectionTypes: [ORKConsentSectionType] = [
        .overview,
        .dataGathering,
        .privacy,
        .dataUse,
        .timeCommitment,
        .studySurvey,
        .studyTasks,
        .withdrawing
    ]
    
    let consentSections: [ORKConsentSection] = consentSectionTypes.map { consentSectionType in
        let consentSection = ORKConsentSection(type: consentSectionType)
        consentSection.summary = "If you wish to complete this study..."
        consentSection.content = "In this study you will be asked five (wait, no, three!) questions. You will also have your voice recorded for ten seconds."
        return consentSection
    }
    consentDocument.sections = consentSections
    
    // Get today's date
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = DateFormatter.Style.short
    let convertedDate = dateFormatter.string(from: NSDate() as Date)
    
    // Add a signature to the document
    consentDocument.addSignature(ORKConsentSignature(forPersonWithTitle: "Consent", dateFormatString: convertedDate, identifier: "ConsentDocumentParticipantSignature"))
    
    return consentDocument
}
