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
    
    let section1 = ORKConsentSection(type: .custom)
    section1.title = ""
    section1.content = "The Sutter Health CareKit Application for iPhone (\"CareKit\" or the \"Application\"), as made available through the Apple, Inc. (\"Apple\") App Store is licensed, not sold, to you. As used herein, \"You\" and \"Your\" refer to the individual or entity that wishes to use the Application. Your license to this Application is subject to your prior acceptance of these Mobile Application Terms and Conditions (\"Terms and Conditions\") and you agree that these Terms and Conditions will apply to the CareKit App. Your license to CareKit under these Terms and conditions is granted by Sutter Health (\"Licensor\"). Licensor reserves all ownership and intellectual property rights in and to CareKit inasmuch as proprietary modifications have been made to the open source framework for the Application. CareKit supports the iPhone (the \"Apple Devices\"), and enables users to access, review and use certain data (and perform certain actions with such data) which data may originate by user access/input or where such data is provided by a connection to an instance of the Licensor's electronic health record software, an application licensed by a third party medical provider (\"Your Provider\") under a separate agreement with Licensor."
    consentSections.append(section1)
    
    let section2 = ORKConsentSection(type: .custom)
    section2.title = "Purpose"
    section2.content = "The CareKit Application is provided to educate you on health care and medical issues that may affect your daily life. The Application allows you to view health-related information specific to post-operative care.  CareKit may allow you to arrange for clinical services and access additional services through Your Provider. This Application does not constitute the practice of any medical, nursing or other professional health care advice, diagnosis or treatment."
    consentSections.append(section2)
    
    let section3 = ORKConsentSection(type: .custom)
    section3.title = "Scope of License"
    section3.content = "This license granted to you for the Application by Licensor is limited to a non-exclusive, non-transferable, revocable limited license to run CareKit on your Apple Devices solely for the purpose of performing those functions and tasks available to you as an end user of CareKit who is using any Apple Device that you own or control and as permitted by the Usage Rules set forth in Section 9.b. of the App Store Terms and Conditions (the \"Usage Rules\"). This license does not allow you to use CareKit on any Apple Device that you do not own or control, and you may not distribute or make the Application available over a network where it could be used by multiple devices at the same time. You may not rent, lease, lend, sell, redistribute or sublicense CareKit. You may not copy (except as expressly permitted by this license and the Usage Rules), decompile, reverse engineer, disassemble, attempt to derive the source code of, modify or create derivative works of CareKit, any updates, or any part thereof (except as and only to the extent any foregoing restriction is prohibited by applicable law. Any attempt to do so is a violation of the rights of the Licensor. If you breach this restriction, you may be subject to prosecution and damages. You are not permitted to use CareKit for any purpose other than as expressly permitted under these Terms and Conditions. You acknowledge that the Licensor may audit your use of the Application."
    consentSections.append(section3)
    
    let section4 = ORKConsentSection(type: .custom)
    section4.title = "Consent to Use of Data"
    section4.content = "You agree that Licensor and Your Provider may collect, store, process, maintain, upload, sync, transmit, share, disclose and use certain data and information, including but not limited to information or data regarding the characteristics or usage of your Apple Device, system and application software, and peripherals, as well as personal information, user location data and user generated content (collectively, \"User Data\") to facilitate the provision of the services or functionality of CareKit, including but not limited to authentication, performance optimization, software updates, product support and other services to you related to the Application or to otherwise improve Licensor's ability to provide other services (if any) to you related to the Application. You acknowledge that use of the Application may result in User Data being transmitted between your Apple Device and a database service designated by Your Provider and/or transmitted or disclosed to or accessed by Licensor. Without limiting the foregoing, you acknowledge that: (a) information regarding the hardware model and the IOS version of the Apple Device on which you are running the Application may be collected, transmitted to and stored on a database server designated by Your Provider, may be transmitted to Licensor and may be used to make changes, updates or improvements to or optimize the performance of the Application or to otherwise inform future development; and (b) audit logs reflecting your logins, logouts and the activities you have accessed through your use of the Application may be generated in connection with your use of the Application may be collected, transmitted and stored on a database server designated by Your Provider. Your User Data may also be made available to Licensor for troubleshooting. BY CLICKING THE \"ACCEPT\" BUTTON, YOU EXPRESSLY CONSENT TO THE FOREGOING COLLECTION, STORAGE, PROCESSING, MAINTENANCE, UPLOADING, SYNCING, TRANSMITTING, SHARING, OR DISCLOSURE OF USER DATA. By continuing to use the Application, you indicate your continued consent to such collection, storage, processing maintenance, uploading, syncing, transmitting, sharing, or disclosure of User Data as well as collection, storage, transmission and use of data of the type and in the manner described in Sutter Health's Privacy Policy found at: http://www.sutterhealth.org/policy/.\n\nTHIS APPLICATION DOES NOT PROVIDE MEDICAL ADVICE. The contents of the Application, such as text, graphics, images, data, graphs, audio, videos, computer programs and other material and information (collectively the \"Content\"), are for informational purposes only. THE CONTENT PROVIDED IN THIS APPLICATION IS NOT A SUBSTITUTE FOR THE ADVICE OF YOUR PROFESSIONAL PHYSICIAN OR OTHER QUALIFIED HEALTH CARE PROFESSIONAL. ALWAYS SEEK THE ADVICE OF YOUR PHYSICIAN OR OTHER QUALIFIED HEALTH CARE PROFESSIONAL WITH ANY QUESTIONS YOU MAY HAVE REGARDING A MEDICAL SYMPTOM OR A MEDICAL CONDITION. NEVER DISREGARD PROFESSIONAL MEDICAL ADVICE OR DELAY IN SEEKING IT BECAUSE OF SOMETHING YOU HAVE READ OR SEEN THE CAREKIT APP IS NOT FOR USE IN EMERGENCIES.  YOU SHOULD CALL 911 OR HAVE SOMEONE TAKE YOU TO THE EMERGENCY ROOM IF YOU/THE PATIENT ARE IN NEED OF IMMEDIATE MEDICAL ASSISTANCE."
    consentSections.append(section4)
    
    let section5 = ORKConsentSection(type: .custom)
    section5.title = "Changes and Updates"
    section5.content = "Licensor may revise our policies and the information provided via the CareKit App, or change or update the CareKit App without notice.  We may also make improvements and/or changes in products and/or services described in this information or add new features at any time without notice.  Any revised policy will apply both to information we already have about you at the time of the change, and any personal information created or received after the change takes effect.  We encourage you to reread these terms and conditions periodically to see if there have been any changes to our policies that may affect you. Your continued use of CareKit will signify your continued agreement to these Terms and Conditions as they may be revised."
    consentSections.append(section5)
    
    let section6 = ORKConsentSection(type: .custom)
    section6.title = "Links to Third Party Applications"
    section6.content = "The Application provides links to other websites, applications, or content that are not owned or controlled by the Licensor, including Your Provider (\"Third Party Providers\"). These links are intended to connect you easily to additional sources of health information or third party services that may be of interest to you. We may not have any business relationship with the Third Party Provider that controls this type of content and such links are offered only as a convenience to you. Licensor is not responsible for the content, security or the privacy practices of Third Party Providers. Please review the privacy statement and any terms of use of each Third Party Providers you use. Unless we specifically advise you otherwise, links to Third Party Providers do not constitute or imply endorsement by the Licensor of those sites, the information they contain or any products or services they describe. Licensor does not receive payment or other remuneration in exchange for you linking to or using any information provided by a Third Party Provider."
    consentSections.append(section6)
    
    let section7 = ORKConsentSection(type: .custom)
    section7.title = "Security and Confidentiality"
    section7.content = "We afford the same degree of confidentiality to medical information stored on the Application as is given to health information stored by Licensor in any other medium. Sutter Health is committed to protecting the confidentiality of your health information. We limit our employees' access and ability to enter or view health information based upon their role in your care. We have taken steps to make all health information we receive as secure as possible against unauthorized access, use, or disclosure.  We keep track of visits to the CareKit App and are provided with, among other things, how many downloads of the CareKit App are made and what features are visited.  The monitoring program does not provide us with any personal information about a visitor.  We cannot discern the name, address or any other personal information about end users of the CareKit App."
    consentSections.append(section7)
    
    let section8 = ORKConsentSection(type: .custom)
    section8.title = "DISCLAIMER"
    section8.content = "YOU EXPRESSLY ACKNOWLEDGE AND AGREE THAT USE OF THE APPLICATION AND YOUR RELIANCE ON THE OPERATION, OUTPUT OR RESULTS OF THE APPLICATION IS AT YOUR SOLE RISK AND THAT THE ENTIRE RISK AS TO SATIFACTORY QUALITY, PERFORMANCE, ACCURACY AND EFFORT IS WITH YOU. TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE LAW, THE APPLICATION AND ANY SERVICES PERFORMED OR PROVIDED BY THE APPLICATION (THE “APPLICATION SERVICES”) ARE PORVIDED \"AS IS\" AND \"AS AVAILABLE\", WITH ALL FAULTS AND WITHOUT WARRANTY OF ANY KIND, AND LICENSOR HEREBY DISCLAIMS ALL WARRANTIES AND CONDITIONS WITH REPSECT TO THE APPLICATION AND ANY APPLICATION SERVICES, EITHER EXPRESS, IMPLIED OR STAUTTORY, INCLUDING BUT NOT LIMITED TO, THE IMPIED WARRANTIES AND/OR CONDITIONS OF MERCHANTABILITY, OF SATISFACTORY QUALITY, OF FITNESS FOR A PARTICULAR PURPOSE, OR ACCURACY, OF QUIET ENJOYMENT, AND NON-INFRINGEMENT OF THIRD PARTY RIGHTS. LICENSOR DOES NOT WARRANT AGAINST INTERFERENCE WITH YOUR ENJOYMENT OF THE CAREKIT THAT THE FUNCTIONS CONTAINED IN, OR APPLICATION SERVICES PERFORMED OR PROVIDED BY, CAREKIT WILL MEET YOUR REQUIREMENTS, THAT THE OPERATION OF CAREKIT OR APPLICATION SERVICES WILL BE UNINTERRUPTED OR ERROR-FREE, OR THAT DEFECTS IN THE CAREKIT APPLICATION OR APPLICATION SERVICES WILL BE CORRECTED. NO ORAL OR WRITTEN INFORMATION OR ADVICE GIVEN BY SUTTER HEALTH, ITS AUTHORIZED REPRESENTATIVE, OR YOUR PROVIDER SHALL CREATE A WARRANTY. SHOULD CAREKIT OR APPLICATION SERVICES PROVE DEFECTIVE, YOU ASSUME THE ENTIRE COST OF ALL NECESSARY SERVICING, REPAIR, OR CORRECTION. SOME JURISDICTIONS DO NOT ALLOW THE EXCLUSION OF IMPLIED WARRANTIES OR LIMITATIONS ON APPLICABLE STATUTORY RIGHTS OF A CONSUMER, SO THE ABOVE EXCLUSION AND LIMITATIONS MAY NOT APPLY TO YOU."
    consentSections.append(section8)
    
    let section9 = ORKConsentSection(type: .custom)
    section9.title = "Limitation on Liability"
    section9.content = "SUTTER HEALTH, ITS AFFILIATES, AND SUPPLIERS ARE NEITHER RESPONSIBLE NOR LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, CONSEQUENTIAL, SPECIAL, EXEMPLARY, PUNITIVE, OR OTHER DAMAGES (INCLUDING, WITHOUT LIMITATION, THOSE RESULTING FROM LOST PROFITS, LOST DATA, OR BUSINESS INTERRUPTION) ARISING OUT OF OR RELATING IN ANY WAY TO THE APPLICATION, SITE-RELATED SERVICES AND PRODUCTS, CONTENT OR INFORMATION CONTAINED WITHIN THE APPLICATION, AND/OR ANY THIRD PARTY WEB SITE, WHETHER BASED ON WARRANTY, CONTRACT, TORT, OR ANY OTHER LEGAL THEORY AND WHETHER OR NOT ADVISED OF THE POSSIBILITY OF SUCH DAMAGES. YOUR SOLE REMEDY FOR DISSATISFACTION WITH THIS APPLICATION, APPLICATION SERVICES, AND/OR THIRD PARTY WEB SITES IS TO STOP USING THE APPLICATION AND/OR THOSE SERVICES. THESE TERMS AND CONDITIONS ARE GOVERNED BY CALIFORNIA LAW WITHOUT REGARD TO ITS PRINCIPLES OF CONFLICTS OF LAW. IF ANY VERSION OF THE UNIFORM COMPUTER INFORMATION TRANSACTIONS ACT (UCITA) IS ENACTED AS PART OF THE LAW OF CALIFORNIA, THAT STATUTE SHALL NOT GOVERN ANY ASPECT OF THESE TERMS AND CONDITIONS."
    consentSections.append(section9)
    
    let section10 = ORKConsentSection(type: .custom)
    section10.title = "Indemnity"
    section10.content = "You agree to defend, indemnify, and hold Sutter Health harmless including Sutter Health officers, directors, employees, agents, subcontractors, licensors and suppliers, any of our affiliated companies or organizations, and any successors, assigns or licensees, from and against any claims, actions or demands, damages, losses, liabilities, judgments, settlements, costs or expenses (including attorneys' fees and costs) arising directly or indirectly from or relating to a) the breach of this Agreement by you or anyone using your computer, mobile device, password or login information; (b) any claim, loss or damage experienced from your use or attempted use of (or inability to use) the Application; (c) your violation of any law or regulation; or (d) any other matter for which you are responsible under this Agreement or under law. You agree that your use of the CareKit Application shall be in compliance with all applicable laws, regulations and guidelines."
    consentSections.append(section10)
    
    let section11 = ORKConsentSection(type: .custom)
    section11.title = "Prohibited Activity"
    section11.content = "You agree that you will not upload or transmit any communications or content of any type (including secure messaging) that infringe upon, misappropriate or violate any rights of any party. In consideration of being allowed to use the Application, you agree that the following actions shall constitute a material breach of these Terms and Conditions: (a) signing on as or pretending to be another person; (b) using secure messaging for any purpose in violation of local, state, national, international laws or posted Licensor policies; (c) transmitting material that infringes or violates the intellectual property rights of others or the privacy or publicity rights of others; (d) transmitting material that is unlawful, obscene, defamatory, predatory of minors, threatening, harassing, abusive, slanderous, or hateful to any person (including Licensor personnel) or entity as determined by Licensor in its sole discretion; (e) using interactive services in a way that is intended to harm, or a reasonable person would understand would likely result in harm, to the user or others; (f) collecting information about others, including e-mail addresses; (g) intentionally distributing viruses or other harmful computer code; and (i) Licensor expressly reserves the right, in its sole discretion, to terminate a User's access to the Application due to any act delineated above, or any act that would constitute a violation of these Terms and Conditions."
    consentSections.append(section11)
    
    let section12 = ORKConsentSection(type: .custom)
    section12.title = "Copyrights"
    section12.content = "Except as otherwise indicated, all content in the CareKit App, including text, graphics, logos, button icons, photos, images, forms, audio, video, \"look and feel\" and software, is the property of Sutter Health and/or its licensors and is protected by the United States and international copyright laws.  The compilation of all content on this site is the exclusive property of Sutter Health and/or its licensors and is protected by United States and international copyright laws.  Unless specifically authorized in writing by Sutter Health, any use of these materials, or of any materials contributed to this CareKit App by entities other than Sutter Health is prohibited.  Any rights not expressly granted by these terms and conditions or any applicable end-user license agreements are reserved by Sutter Health.  Permission to display publicly, reprint or reproduce electronically any document or graphic in whole or in part for any reason is expressly prohibited, unless prior written consent is obtained from the copyright holder(s)."
    consentSections.append(section12)
    
    let section13 = ORKConsentSection(type: .custom)
    section13.title = "Trademarks and Service Marks"
    section13.content = "\"Sutter Health\" and the Sutter Health logo are service marks of Sutter Health.  Sutter Health may designate other proprietary rights from time to time on this site through use of TM, SM or ® symbols.  Users of the CareKit App are not authorized to make any use of the Sutter Health marks, including, but not limited to, as metatags or in any other fashion which may create a false or misleading impression of affiliation or sponsorship with or by Sutter Health.  Any other trademarks or service marks are the property of the respective owners."
    consentSections.append(section13)
    
    let section14 = ORKConsentSection(type: .custom)
    section14.title = "Infringement"
    section14.content = "Under the Digital Millennium Copyright Act of 1998 (the \"DMCA\"), it is Sutter Health's policy to respond to copyright owners who believe material appearing on the Application infringes their rights under US copyright law. Licensor accepts no responsibility or liability for any material provided or posted by a user. If you believe that something appearing on CareKit infringes your copyright, you may send us a notice requesting that it be removed, or access to it blocked. If you believe that such a notice has been wrongly filed against you, the DMCA lets you send us a counter-notice. All notices and counter-notices must meet the DMCA's requirements. We suggest that you consult your legal advisor before filing a notice or counter-notice. Be aware that there can be substantial penalties for false claims. It is our policy to terminate the accounts of repeat infringers in appropriate circumstances."
    consentSections.append(section14)
    
    let section15 = ORKConsentSection(type: .custom)
    section15.title = "Third Party Beneficiary"
    section15.content = "You acknowledge and agree that Apple and its subsidiaries are third party beneficiaries to these Terms and Conditions and that upon your acceptance of these Terms and Conditions, Apple will have the right (and will deemed to have accepted the right) to enforce these Terms and Conditions against you as a third party beneficiary thereof."
    consentSections.append(section15)
    
    let section16 = ORKConsentSection(type: .custom)
    section16.title = "Termination"
    section16.content = "This Agreement is effective until terminated by either you or us. You may terminate this Agreement at any time, provided that you discontinue any further use of the Application. If you violate this Agreement, our permission to you to use CareKit automatically terminates. We may, in our sole discretion, terminate this Agreement and your access to any or all of CareKit, at any time and for any reason, without penalty or liability to you or any third party. In the event of your breach of this Agreement, these actions are in addition to and not in lieu or limitation of any other right or remedy that may be available to us. Upon any termination of the Agreement by either you or us, you must promptly uninstall the App on all of your devices and destroy all materials downloaded or otherwise obtained from CareKit, all documentation, and all copies of such materials and documentation."
    consentSections.append(section16)
    
    let section17 = ORKConsentSection(type: .custom)
    section17.title = "Contact"
    section17.content = "The Licensor of the Application is Sutter Health, located at 2200 River Plaza Drive, Sacramento, California 95833.  If you have any questions about CareKit, please send an email to support@sutterhealth.org."
    consentSections.append(section17)
    
    consentDocument.sections = consentSections
    
    // Get today's date
    //let dateFormatter = DateFormatter()
    //dateFormatter.dateStyle = DateFormatter.Style.short
    //let convertedDate = dateFormatter.string(from: NSDate() as Date)
    
    // Add a signature to the document
    //consentDocument.addSignature(ORKConsentSignature(forPersonWithTitle: "Consent", dateFormatString: convertedDate, identifier: "ConsentDocumentParticipantSignature"))
    
    return consentDocument
}
