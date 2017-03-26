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
    
    fileprivate var sections: [String] = []
    fileprivate var dataSource: [[BinderResource]] = []
    
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
        
        // Load in the data
        let binder = ProfileManager.sharedInstance.getUserLocation().binder
        for (index, section) in binder.enumerated() {
            sections.append(section.section)
            dataSource.append([])
            for subsection in section.subsections {
                dataSource[index].append(BinderResource(title: subsection.title, htmlFile: subsection.file))
            }
        }
        
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
