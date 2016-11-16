//
//  SettingsViewController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/4/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit


class SettingsViewController: UITableViewController {
    
    // Data source
    var dataSource = [[SettingsItem]]()
    
    
    // MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required override init(style: UITableViewStyle) {
        super.init(style: style)
    }
    
    convenience init() {
        self.init(style: UITableViewStyle.grouped)
        
        // Add data to the data source
        dataSource.append([SettingsItem]())
        dataSource[0].append(SettingsItem(name: "Profile", icon: "profile-icon", className: "ProfileViewController"))
        
        dataSource.append([SettingsItem]())
        dataSource[1].append(SettingsItem(name: "Notes", icon: "notes-icon", className: "NotesViewController"))
        dataSource[1].append(SettingsItem(name: "Resources", icon: "resources-icon", className: "ResourcesViewController"))
        
        dataSource.append([SettingsItem]())
        dataSource[2].append(SettingsItem(name: "Pre-Surgery Expectations", icon: "expectations-icon", className: "ExpectationsViewController"))
        dataSource[2].append(SettingsItem(name: "Post-Surgery Expectations", icon: "expectations-icon", className: "ExpectationsViewController"))
        
        dataSource.append([SettingsItem]())
        dataSource[3].append(SettingsItem(name: "Legal / Consent", icon: "legal-icon", className: "LegalViewController"))
        dataSource[3].append(SettingsItem(name: "FAQ", icon: "faq-icon", className: "FAQViewController"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Customize the table view
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
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
        return self.dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get the data source
        let data = self.dataSource[indexPath.section][indexPath.row]
        
        // Set the cell
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = data.name
        cell.accessoryType = .disclosureIndicator
        cell.imageView?.image = UIImage(named: data.icon!)
        
        // Return the cell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get the class name
        let data = self.dataSource[indexPath.section][indexPath.row]
        let className: String! = data.className
        
        // Combine the app and class names
        let appClassName = "Bees_Knees" + "." + className
        
        // Get the class object
        let classObj = NSClassFromString(appClassName) as! UIViewController.Type
        let vc = classObj.init()
        vc.title = NSLocalizedString(data.name, comment: "")
        
        // Push this view controller
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
