#JointCare app

###Configuration:

**Step 1:** Clone this repository, CareKit, and ResearchKit, all in the same ROOT directory:

```
# Create a new directory for the JointCare project
mkdir JointCare
cd JointCare

# Clone the required repositories
git clone https://github.com/PAMFInnovation/bees-knees
git clone https://github.com/carekit-apple/CareKit
git clone https://github.com/ResearchKit/ResearchKit
```
**Step 2:** Set up Carthage on your local machine. You can install it from 
https://github.com/Carthage/Carthage/releases

Once you install Carthage, update the project using Terminal.
Run "carthage update" from your project root folder.

**Step 3:** Open the *bees-knees* project:

```
open Bees\ Knees.xcodeproj/
```

**Step 4:** Build and Run in XCode

-

*Additional Details:*  
- Required XCode Version: **8.2.1+**  
- Required iOS Version: **9.3+**  
- Supported Devices: **iPhone 5+**  
- Capabilities: **none**  

###Frameworks:
1) [Realm](https://realm.io/)  

An open-source framework for saving data to the device as an alternative to CoreData. Allows us to persist data easily and provides a useful interface for retrieving and updating that data.

2) [CareKit](https://github.com/carekit-apple/CareKit/)  

Apple's open-source framework that provides modules for tracking exercises, recording assessments, displaying insights, and storing contacts. This framework is used specifically to build the following views:

* Activities
* Progress Tracker
* Progress History

3) [ResearchKit](https://github.com/researchkit/researchkit)  

Apple's open-source framework that provides tools for integrating tasks into the app, including surveys, consent, active tasks, and charts. This framework is used specifically to build the consent form, build the custom line graph that is presented on the Progress History page, and other views that use the task flow.meat

4) [Gloss](https://github.com/hkellaway/Gloss)  

An open-source framework that provides tools JSON mapping. 
    Mapping JSON to objects, 
    Mapping objects to JSON
    Nested objects
    Custom transformations
  

###Source Code:
The directory structure is mostly defined by app feature. At the root exists `RootViewController.swift` which is the top-level view controller added to the stack. It primarily governs the flow of the app, including switching view controllers when necessary.

```
ROOT
|-- Bees Knees
    |-- activities				// Custom implementation of CareCard Activity to support additional content
    |-- appointments			// TVC for appointment module
    |-- checklist				// TVC for checklist module
    |-- ck-activities			// List of all custom CareKit Activities
    |-- ck-assessments			// List of all custom CareKit Assessments
    |-- ck-insights				// Classes and functions for generating insights to display on Insight VC
    |-- consent					// Consent Task and legal copy
    |-- content					// All local content including videos, images, and html
    |-- date-of-surgery			// Custom view for changing date of surgery
    |-- extensions				// All extensions
    |-- faq						// TVC for display FAQs
    |-- interfaces				// All .xib interfaces
    |-- internal				// Persistent data stores and user profile
    |-- legal					// VC for signed consent document
    |-- notes					// VC for notes module (found in settings)
    |-- passcode				// Passcode task
    |-- post-transition			// VC for displaying post-surgery transition views
    |-- presentations			// Custom presentations used for displaying binder content
    |-- resources				// TVC for binder module (found in settings)
    |-- roadmap					// TVC for roadmap module
    |-- settings				// TVC for settings module
    |-- shared					// All shared modules and views
    |-- tutorial				// Custom tutorial controllers and views (not used currently)
    |-- util					// Basic utilities and copy
    |-- welcome					// VC for displaying app welcome flow
    |-- Info.plist
    |-- AppDelegate.swift
    |-- RootViewController.swift
    |-- Assets.xcassets
    |-- LaunchScreen.storyboard
    |-- Main.storyboard
```

### Other Considerations:
This app relies little on .xib or .storyboard files. Most, if not all, of the views are built with code.
