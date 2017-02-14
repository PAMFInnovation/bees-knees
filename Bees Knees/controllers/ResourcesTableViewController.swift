//
//  ResourcesTableViewController
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 2/4/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import Foundation
import UIKit


class ResourcesTableViewController: UITableViewController {
    
    // MARK: - Properties
    fileprivate let cellIdentifier = "myCell"
    fileprivate let headerIdentifier = "myHeader"
    
    fileprivate let sectionInsets: UIEdgeInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
    
    fileprivate let itemsPerRow: CGFloat = 3
    
    fileprivate let sections: [String] = [
        //"Understanding Knee Replacement",
        "Before Surgery",
        "Your Surgery and Hospital Stay",
        "Rehabilitation and Home Recovery",
        "Knee Replacement Exercises",
        "Life with Your New Knee",
        "Knee Replacement Resources",
        "Alta Bates Summit Map"
    ]
    fileprivate let dataSource: [[BinderResource]] = [
        /*// Understanding Knee Replacement
        [
            BinderResource(title: "Understanding Knee Replacement", htmlFile: "understanding-knee-replacement")
        ],*/
        // Before Surgery
        [
            BinderResource(title: "Understanding Knee Replacement", htmlFile: "understanding-knee-replacement"),
            BinderResource(title: "Select a Coach", htmlFile: "select-your-coach"),
            BinderResource(title: "Surgical Clearance", htmlFile: "surgical-clearance"),
            BinderResource(title: "Pre-op Appointment", htmlFile: "pre-operative-appointments"),
            BinderResource(title: "Dental Work", htmlFile: "dental-work"),
            BinderResource(title: "Exercise", htmlFile: "exercise-before-surgery"),
            BinderResource(title: "Nutrition", htmlFile: "nutrition"),
            BinderResource(title: "Home Prep", htmlFile: "preparing-for-your-return-home"),
            BinderResource(title: "Pack Your Bag", htmlFile: "packing-your-bag"),
            BinderResource(title: "Getting Sick", htmlFile: "last-minute-illness"),
            BinderResource(title: "Food Before Surgery", htmlFile: "no-eating-or-drinking-before-surgery"),
            BinderResource(title: "Smoking Cessation", htmlFile: "smoking-cessation")
        ],
        // Your Surgery and Hospital Stay
        [
            BinderResource(title: "Arriving for Surgery", htmlFile: "arriving-for-surgery"),
            BinderResource(title: "Your Orthopedic Healthcare Team", htmlFile: "your-orthopedic-healthcare-team"),
            BinderResource(title: "Surgery", htmlFile: "surgery"),
            BinderResource(title: "After Surgery", htmlFile: "after-surgery"),
            BinderResource(title: "Pain Management", htmlFile: "pain-management"),
            BinderResource(title: "During Your Hospitalization", htmlFile: "during-your-hospitalization"),
            BinderResource(title: "Types of Pain Management", htmlFile: "types-of-pain-management"),
            BinderResource(title: "Questions About Pain", htmlFile: "questions-about-pain"),
            BinderResource(title: "Patient Information", htmlFile: "patient-information-from-easy-bay-anesthesia-medical-group"),
            BinderResource(title: "Daily Post-Operative Expectations", htmlFile: "daily-post-operative-expectations"),
            BinderResource(title: "Possible Complications", htmlFile: "possible-complications")
        ],
        // Rehabilitation and Home Recovery
        [
            BinderResource(title: "Rehabilitation", htmlFile: "rehabilitation"),
            BinderResource(title: "Physical Therapy in the Hospital, SNF and Acute Rehabilitation", htmlFile: "physical-therapy-in-the-hospital-snf-and-acute-rehabilitation"),
            BinderResource(title: "Occupational Therapy in the Hospital, SNF, Acute Rehabilitation", htmlFile: "occupational-therapy-in-the-hospital-snf-acute-rehabilitation"),
            BinderResource(title: "After the Hospital", htmlFile: "after-the-hospital"),
            BinderResource(title: "Post-Hospital Discharge", htmlFile: "post-hospital-discharge"),
            BinderResource(title: "Home Recovery", htmlFile: "home-recovery")
        ],
        // Knee Replacement Exercises
        [
            BinderResource(title: "Total Knee Replacement Exercises", htmlFile: "total-knee-replacement-exercises"),
            BinderResource(title: "How to Use an Incentive Spirometer", htmlFile: "how-to-use-an-incentive-spirometer")
        ],
        // Life with Your New Knee
        [
            BinderResource(title: "Quick Guide to Home Care Instructions", htmlFile: "quick-guide-to-home-care-instructions"),
            BinderResource(title: "Follow-up Appointments", htmlFile: "follow-up-appointments"),
            BinderResource(title: "Dental Work Precautions", htmlFile: "dental-work-precautions"),
            BinderResource(title: "Driving", htmlFile: "driving"),
            BinderResource(title: "Air Travel and Metal Detectors", htmlFile: "air-travel-and-metal-detectors"),
            BinderResource(title: "Sexual Activities", htmlFile: "sexual-activities")
        ],
        // Knee Replacement Resources
        [
            BinderResource(title: "Alta Bates Summit Medical Center", htmlFile: "alta-bates-summit-medical-center"),
            BinderResource(title: "Other Websites", htmlFile: "other-websites"),
            BinderResource(title: "Other Exercise Resources", htmlFile: "other-exercise-resources")
        ],
        // Alta Bates Summit Map
        [
            BinderResource(title: "Alta Bates Summit Campus Locations", htmlFile: "alta-bates-summit-campus-locations")
        ]
    ]
    
    lazy var slideInTransitionDelegate = SlideInPresentationManager()
    
    
    // MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(style: UITableViewStyle) {
        super.init(style: style)
    }
    
    convenience init() {
        self.init(style: .grouped)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // White background color
        self.tableView?.backgroundColor = UIColor.white
        
        // Customize the table view
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    
    // MARK: - Table View Delegate
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get the data source
        let data = dataSource[indexPath.section][indexPath.row]
        
        // Get the cell
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = data.title
        cell.selectedBackgroundView = UIView()
        cell.selectedBackgroundView?.backgroundColor = UIColor.init("#F1F1F4")
        
        // Return the cell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Create the resource view controller
        let resourceViewController = ResourceViewController(htmlFile: dataSource[indexPath.section][indexPath.row].htmlFile)
        
        // Custom presentation
        slideInTransitionDelegate.direction = .bottom
        resourceViewController.transitioningDelegate = slideInTransitionDelegate
        resourceViewController.modalPresentationStyle = .custom
        self.present(resourceViewController, animated: true, completion: {
            self.tableView.deselectRow(at: indexPath, animated: true)
        })
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = ResourceTableHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 60))
        view.backgroundColor = UIColor.init("#F0EFF5")
        view.title.text = sections[section].uppercased()
        
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}
