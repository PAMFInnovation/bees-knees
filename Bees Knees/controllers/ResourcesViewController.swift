//
//  ResourcesViewController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/4/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit


class ResourcesViewController: UITableViewController {
    
    // Data source
    var dataSource = [Resource]()
    
    
    // MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        // Add the resources
        dataSource.append(Resource(type: .DOC, title: "Surgery overview.", fileName: "sample-doc", fileType: "pdf"))
        dataSource.append(Resource(type: .DOC, title: "Walkthrough of the procedure.", fileName: "sample-doc", fileType: "pdf"))
        dataSource.append(Resource(type: .VIDEO, title: "Testimonials from the patients of Sutter.", fileName: "sample-video", fileType: "m4v"))
        dataSource.append(Resource(type: .IMAGE, title: "Banner", fileName: "sample-banner-image", fileType: "jpg"))
        dataSource.append(Resource(type: .IMAGE, title: "GIF", fileName: "sample-gif", fileType: "gif"))
        dataSource.append(Resource(type: .IMAGE, title: "PNG", fileName: "sample-png", fileType: "png"))
        dataSource.append(Resource(type: .IMAGE, title: "Portrait", fileName: "sample-portrait-image", fileType: "jpg"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.lightGray
        
        // Customize the table view
        self.tableView.register(ResourceTableViewCell.self, forCellReuseIdentifier: "myCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // Hide the footer
        self.tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    
    // MARK: - Table View Delegate
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get the data source
        let data = dataSource[indexPath.row]
        
        // Get the cell
        let cell: ResourceTableViewCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! ResourceTableViewCell
        cell.setResourceObject(data)
        
        // Return the cell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get the data source
        let data = dataSource[indexPath.row]
        
        // Show the resource controller
        switch data.type! {
        case .DOC:
            self.navigationController?.pushViewController(DocViewController(file: data.fileName, type: data.fileType), animated: true)
        case .IMAGE:
            self.navigationController?.pushViewController(ImageViewController(file: data.fileName, type: data.fileType), animated: true)
        case .VIDEO:
            self.navigationController?.pushViewController(VideoViewController(file: data.fileName, type: data.fileType), animated: true)
        }
    }
}
