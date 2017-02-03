//
//  ActivityDetailViewController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 2/2/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import UIKit
import CareKit


class ActivityDetailViewController: UITableViewController {
    
    // MARK: - Properties
    let HeaderViewHeight: CGFloat = 70.0
    let InstructionsCellIdentifier: String = "InstructionsCell"
    let InstructionsTitle: String = "Instructions"
    let RationaleCellIdentifier: String = "RationaleCell"
    let RationaleTitle: String = "Why this is important"
    let ImageCellIdentifier: String = "ImageCell"
    let ImageTitle: String = "Image"
    
    var activity: ActivityContainer?
    var headerView: ActivityDetailHeaderView?
    
    var sectionTitles: [String] = []
    
    
    // MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required override init(style: UITableViewStyle) {
        super.init(style: style)
    }
    
    convenience init(activity: ActivityContainer) {
        self.init(style: .grouped)
        self.activity = activity
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prepareView()
        
        self.tableView.register(ActivityDetailInstructionsTableViewCell.self, forCellReuseIdentifier: InstructionsCellIdentifier)
        self.tableView.register(ActivityDetailRationaleTableViewCell.self, forCellReuseIdentifier: RationaleCellIdentifier)
        self.tableView.register(ActivityDetailImageTableViewCell.self, forCellReuseIdentifier: ImageCellIdentifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 44.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.tableFooterView = UIView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let height: CGFloat = (headerView?.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height)!
        var headerViewFrame: CGRect = headerView!.frame
        
        if height != headerViewFrame.size.height {
            headerViewFrame.size.height = height
            headerView?.frame = headerViewFrame
            self.tableView.tableHeaderView = headerView
        }
    }
    
    
    // MARK: - Helper functions
    func prepareView() {
        headerView = ActivityDetailHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: HeaderViewHeight))
        headerView?.setShowEdgeIndicator(false)
        headerView?.activity = activity
        
        self.tableView.tableHeaderView = headerView
        
        self.createTableViewDataArray()
    }
    
    func createTableViewDataArray() {
        if ((activity?.carePlanActivity.instructions) != nil) {
            sectionTitles.append(InstructionsTitle)
        }
        
        if ((activity?.activity.rationale) != "") {
            sectionTitles.append(RationaleTitle)
        }
        
        if ((activity?.activity.image.name) != "") {
            sectionTitles.append(ImageTitle)
        }
    }
    
    
    // MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    
    // MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionTitle: String = sectionTitles[indexPath.section]
        
        if sectionTitle == InstructionsTitle {
            let cell: ActivityDetailInstructionsTableViewCell = tableView.dequeueReusableCell(withIdentifier: InstructionsCellIdentifier) as! ActivityDetailInstructionsTableViewCell
            cell.activity = activity
            
            return cell
        }
        else if sectionTitle == RationaleTitle {
            let cell: ActivityDetailRationaleTableViewCell = tableView.dequeueReusableCell(withIdentifier: RationaleCellIdentifier) as! ActivityDetailRationaleTableViewCell
            cell.activity = activity
            
            return cell
        }
        else if sectionTitle == ImageTitle {
            let cell: ActivityDetailImageTableViewCell = tableView.dequeueReusableCell(withIdentifier: ImageCellIdentifier) as! ActivityDetailImageTableViewCell
            cell.activity = activity
            
            return cell
        }
        
        return UITableViewCell(style: .default, reuseIdentifier: "myCell")
    }
}
