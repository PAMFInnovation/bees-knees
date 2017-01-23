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
        "Before surgery",
        "Your Surgery and Hospital Stay",
        "Rehabilitation and Home Recovery",
        "Knee Replacement Exercises",
        "Life with Your New Knee",
        "Knee Replacement Resources",
        "Alta Bates Summit Map"
    ]
    fileprivate let dataSource: [[BinderResource]] = [
        [
            BinderResource(title: "Select a Coach", htmlFile: "select-your-coach"),
            BinderResource(title: "Surgical Clearance", htmlFile: "surgical-clearance"),
            BinderResource(title: "Pre-op Appointment", htmlFile: "pre-operative-appointments"),
            BinderResource(title: "Dental Work", htmlFile: "dental-work"),
            BinderResource(title: "Exercise", htmlFile: "exercise-before-surgery"),
            BinderResource(title: "Nutrition", htmlFile: ""),
            BinderResource(title: "Home Prep", htmlFile: ""),
            BinderResource(title: "Pack Your Bag", htmlFile: ""),
            BinderResource(title: "Getting Sick", htmlFile: ""),
            BinderResource(title: "Smoking Cessation", htmlFile: "")
        ],
        [
        ],
        [
        ],
        [
        ],
        [
        ],
        [
        ],
        [
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
