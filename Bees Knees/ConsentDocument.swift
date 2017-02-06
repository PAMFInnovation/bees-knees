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
    consentDocument.title = "Terms and Conditions"
    
    /*let consentSectionTypes: [ORKConsentSectionType] = [
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
        consentSection.title = "Test Title"
        consentSection.summary = "If you wish to complete this study..."
        consentSection.content = "In this study you will be asked five (wait, no, three!) questions. You will also have your voice recorded for ten seconds."
        return consentSection
    }*/
    
    /*
     Notice
     Privacy/Terms and Conditions
     Disclaimer
     Copyrights
     Trademarks and Service Marks
     */
    
    var consentSections: [ORKConsentSection] = []
    
    let noticeSection = ORKConsentSection(type: .custom)
    noticeSection.title = "Notice"
    noticeSection.content = "This Sutter Health Mobile Application (\"Mobile App\") is provided by Sutter Health as a convenience. The Mobile App is not for use in emergencies. You should call 911 or have someone take you to the emergency room if you/the patient are in need of immediate medical assistance."
    consentSections.append(noticeSection)
    
    let privacySection = ORKConsentSection(type: .custom)
    privacySection.title = "Privacy"
    privacySection.content = "This Mobile App is designed to provide useful information about Total Knee Replacement surgery and give patients a tool to track exercises.\n\nAll health-related information provided via the Mobile App is intended to educate and inform users about illnesses and conditions and ways to maintain optimum health. It is not intended to diagnose personal physical conditions and is not a substitute for consulting with one’s own personal health care provider.\n\nBy viewing information on the Mobile App, you are agreeing to the following terms and conditions:\n\nWe may revise our policies and the information provided via the Mobile App, or change or update the Mobile App without notice.  We may also make improvements and/or changes in products and/or services described in this information or add new features at any time without notice. Any revised policy will apply both to information we already have about you at the time of the change, and any personal information created or received after the change takes effect. We encourage you to reread these terms and conditions periodically to see if there have been any changes to our policies that may affect you.\n\nWe keep track of visits to the Mobile App and are provided with, among other things, how many downloads of the Mobile App are made and what features are visited.  The monitoring program does not provide us with any personal information about a visitor.  We cannot discern the name, address or any other personal information about end users of the Mobile App.\n\nAlthough we attempt to ensure the integrity and accurateness of the Mobile App, we make no guarantees as to its correctness or accuracy. It is possible that the Mobile App could include typographical errors, inaccuracies or other errors, and that unauthorized additions, deletions and alterations could be made by third parties.  In the event that an inaccuracy arises, please inform us so that it can be corrected.\n\nSUTTER HEALTH PROVIDES THE INFORMATION ON THE MOBILE APP “AS IS”, WITH ALL FAULTS, WITH NO REPRESENTATIONS OR WARRANTIES OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT.  YOU ASSUME TOTAL RESPONSIBILITY AND RISK FOR YOUR USE OF THE MOBILE APP, ITS RELATED SERVICES AND HYPERLINKED SERVICES AND WEBSITES. NO ORAL OR WRITTEN INFORMATION OR ADVICE GIVEN BY SUTTER HEALTH NOR ITS AUTHORIZED REPRESENTATIVES SHALL CREATE A WARRANTY NOR IN ANY WAY INCREASE THE SCOPE OF THIS WARRANTY.\n\nSUTTER HEALTH IS NEITHER RESPONSIBLE NOR LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, CONSEQUENTIAL, SPECIAL, EXEMPLARY, PUNITIVE, OR OTHER DAMAGES (INCLUDING, WITHOUT LIMITATION, THOSE RESULTING FROM LOST PROFITS, LOST DATA, OR BUSINESS INTERRUPTION) ARISING OUT OF OR RELATING IN ANY WAY TO THE MOBILE APP, ITS RELATED SERVICES AND PRODUCTS, CONTENT OR INFORMATION CONTAINED WITHIN THE MOBILE APP, AND/OR ANY HYPERLINKED SERVICE OR WEBSITE, WHETHER BASED ON WARRANTY, CONTRACT, TORT, OR ANY OTHER LEGAL THEORY AND WHETHER OR NOT ADVISED OF THE POSSIBILITY OF SUCH DAMAGES. YOUR SOLE REMEDY FOR DISSATISFACTION WITH THE MOBILE APP IS TO STOP USING THE MOBILE APP AND/OR THOSE SERVICES.  APPLICABLE LAW MAY NOT ALLOW THE EXCLUSION OR LIMITATION OF INCIDENTAL OR CONSEQUENTIAL DAMAGES, SO THE ABOVE LIMITATION OR EXCLUSION MAY NOT APPLY TO YOU."
    consentSections.append(privacySection)
    
    let disclaimerSection = ORKConsentSection(type: .custom)
    disclaimerSection.title = "Disclaimer"
    disclaimerSection.content = "When you leave the Mobile App, you may at your option use other related mobile apps and content. Linking to such mobile apps is at the discretion of the user. These mobile apps may have different user agreements unique to each app. The user is responsible for the cost of medical consultation services including co-pays and any other policies that may be required by their individual or group health plan.\n\nAll health-related information provided via the Mobile App is intended to educate and inform visitors about illnesses and conditions and ways to maintain optimum health. It is not intended to diagnose personal physical conditions and is not a substitute for consulting with a physician or other health care provider."
    consentSections.append(disclaimerSection)
    
    let copyrightsSection = ORKConsentSection(type: .custom)
    copyrightsSection.title = "Copyrights"
    copyrightsSection.content = "Except as otherwise indicated, all content in the Mobile App, including text, graphics, logos, button icons, photos, images, forms, audio, video, \"look and feel\" and software, is the property of Sutter Health and/or its licensors and is protected by the United States and international copyright laws. The compilation of all content on this site is the exclusive property of Sutter Health and/or its licensors and is protected by United States and international copyright laws. Unless specifically authorized in writing by Sutter Health, any use of these materials, or of any materials contributed to this Mobile App by entities other than Sutter Health is prohibited. Any rights not expressly granted by these terms and conditions or any applicable end-user license agreements are reserved by Sutter Health. Permission to display publicly, reprint or reproduce electronically any document or graphic in whole or in part for any reason is expressly prohibited, unless prior written consent is obtained from the copyright holder(s)."
    consentSections.append(copyrightsSection)
    
    let trademarkSection = ORKConsentSection(type: .custom)
    trademarkSection.title = "Trademarks and Service Marks"
    trademarkSection.content = "\"Sutter Health\" and the Sutter Health logo are service marks of Sutter Health. Sutter Health may designate other proprietary rights from time to time on this site through use of TM, SM or ® symbols. Users of the Mobile App are not authorized to make any use of the Sutter Health marks, including, but not limited to, as metatags or in any other fashion which may create a false or misleading impression of affiliation or sponsorship with or by Sutter Health.\n\nAny other trademarks or service marks are the property of the respective owner."
    consentSections.append(trademarkSection)
    
    consentDocument.sections = consentSections
    
    // Get today's date
    //let dateFormatter = DateFormatter()
    //dateFormatter.dateStyle = DateFormatter.Style.short
    //let convertedDate = dateFormatter.string(from: NSDate() as Date)
    
    // Add a signature to the document
    //consentDocument.addSignature(ORKConsentSignature(forPersonWithTitle: "Consent", dateFormatString: convertedDate, identifier: "ConsentDocumentParticipantSignature"))
    
    return consentDocument
}
