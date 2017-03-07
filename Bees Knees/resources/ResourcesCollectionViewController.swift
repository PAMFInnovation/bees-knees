//
//  ResourcesCollectionViewController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 1/18/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import Foundation
import UIKit


struct BinderResource {
    let title: String
    let htmlFile: String
}

class ResourcesCollectionViewController: UICollectionViewController {
    
    // MARK: - Properties
    fileprivate let cellIdentifier = "myCell"
    fileprivate let headerIdentifier = "myHeader"
    
    fileprivate let sectionInsets: UIEdgeInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
    
    fileprivate let itemsPerRow: CGFloat = 3
    
    fileprivate let sections: [String] = [
        "Understanding Knee Replacement",
        "Before Surgery",
        "Your Surgery and Hospital Stay",
        "Rehabilitation and Home Recovery",
        "Knee Replacement Exercises",
        "Life with Your New Knee",
        "Knee Replacement Resources",
        "Alta Bates Summit Map"
    ]
    fileprivate let dataSource: [[BinderResource]] = [
        // Understanding Knee Replacement
        [
            BinderResource(title: "Understanding Knee Replacement", htmlFile: "understanding-knee-replacement")
        ],
        // Before Surgery
        [
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
    
    required override init(collectionViewLayout: UICollectionViewLayout) {
        super.init(collectionViewLayout: collectionViewLayout)
    }
    
    convenience init() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 30.0, left: 30.0, bottom: 30.0, right: 30.0)
        layout.itemSize = CGSize(width: 70.0, height: 70.0)
        self.init(collectionViewLayout: layout)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // White background color
        self.collectionView?.backgroundColor = UIColor.white
        
        // Customize the table view
        self.collectionView?.register(ResourceCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        self.collectionView?.register(ResourceCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.collectionView?.allowsSelection = true
    }
}

extension ResourcesCollectionViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Get the cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ResourceCollectionViewCell
        
        // Set cell details
        cell.textView.text = dataSource[indexPath.section][indexPath.row].title.uppercased()
        cell.htmlFile = dataSource[indexPath.section][indexPath.row].htmlFile
        cell.delegate = self
        
        // Force the text in a UITextView to always center itself.
        var topCorrect = (cell.textView.bounds.size.height - cell.textView.contentSize.height * cell.textView.zoomScale) / 2
        topCorrect = topCorrect < 0.0 ? 0.0 : topCorrect;
        cell.textView.contentInset.top = topCorrect
        
        // Return the cell
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // Get the element
        var reusableView: UICollectionReusableView? = nil
        
        // Create the header
        if kind == UICollectionElementKindSectionHeader {
            let headerView: ResourceCollectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerIdentifier, for: indexPath) as! ResourceCollectionHeaderView
            
            // Set header properties
            headerView.title.text = sections[indexPath.section].uppercased()
            
            reusableView = headerView
        }
        return reusableView!
    }
}

extension ResourcesCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // Evenly space the items using itemsPerRow
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

extension ResourcesCollectionViewController: ResourceCollectionViewCellDelegate {
    func didSelect(sender: ResourceCollectionViewCell) {
        // Create the resource view controller
        let resourceViewController = ResourceViewController(htmlFile: sender.htmlFile!)
        
        // Custom presentation
        slideInTransitionDelegate.direction = .bottom
        resourceViewController.transitioningDelegate = slideInTransitionDelegate
        resourceViewController.modalPresentationStyle = .custom
        self.present(resourceViewController, animated: true, completion: nil)
    }
}
