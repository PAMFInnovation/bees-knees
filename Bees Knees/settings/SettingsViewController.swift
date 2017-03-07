//
//  SettingsViewController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/4/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit
import ResearchKit


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
        dataSource[0].append(SettingsItemNavigation(name: "Notes", header: "Notes", icon: "notes-icon", className: "NotesViewController"))
        
        dataSource.append([SettingsItem]())
        dataSource[1].append(SettingsItemNavigation(name: "Binder", header: "Binder", icon: "resources-icon", className: "ResourcesTableViewController"))
        dataSource[1].append(SettingsItemNavigation(name: "Frequently Asked Questions", header: "FAQs", icon: "faq-icon", className: "FAQViewController"))
        
        dataSource.append([SettingsItem]())
        dataSource[2].append(SettingsItemNavigation(name: "Legal", header: "Legal", icon: "legal-icon", className: "LegalViewController"))
        dataSource[2].append(SettingsItemButton(name: "Passcode", icon: "settings-icon", action: {
            self.setOrEditPasscode()
        }))
        
        dataSource.append([SettingsItem]())
        dataSource[3].append(SettingsItemButton(name: "Reset App Data", action: {
            self.resetData()
        }))
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
    
    
    // MARK: - Helper functions
    func resetData() {
        // Cancel and confirm action
        let cancel: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let confirm: UIAlertAction = UIAlertAction(title: "Reset", style: .destructive, handler: {(alert: UIAlertAction!) in
            // Get the current flow state so we know which view controller to pop
            let flowState = ProfileManager.sharedInstance.getFlowState()
            
            // Reset the player data
            ProfileManager.sharedInstance.resetData()
            
            let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: {(alert: UIAlertAction!) in
                (UIApplication.shared.keyWindow?.rootViewController as! RootViewController).transitionToLaunch(from: flowState)
            })
            self.alert(message: "Your data is now reset. You will be returned to the welcome page.", title: "", cancelAction: nil, confirmAction: okAction)
        })
        
        // Display the confirmation alert
        self.alert(message: "\nThis will reset all saved data and tracked exercises.", title: "ARE YOU SURE?", cancelAction: cancel, confirmAction: confirm)
    }
    
    func setOrEditPasscode() {
        if Util.isSimulator() {
            return
        }
        
        if Util.isPasscodeSet() {
            self.present(ORKPasscodeViewController.passcodeEditingViewController(withText: "", delegate: self as! ORKPasscodeDelegate, passcodeType: .type4Digit), animated: true, completion: nil)
        }
        else {
            let passcodeTVC = ORKTaskViewController(task: PasscodeTask, taskRun: nil)
            passcodeTVC.title = NSLocalizedString("Protect", comment: "")
            passcodeTVC.delegate = self
            self.present(passcodeTVC, animated: true, completion: nil)
        }
    }
    
    
    // MARK: - Table View Delegate
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get the data source and cell
        var data = self.dataSource[indexPath.section][indexPath.row]
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        // Set the cell for navigation types
        if data.type == .Navigation {
            data = (data as! SettingsItemNavigation)
            cell.textLabel?.text = data.name
            cell.accessoryType = .disclosureIndicator
            cell.imageView?.image = UIImage(named: (data as! SettingsItemNavigation).icon)
        }
        // Set the cell for button types
        else if data.type == .Button {
            data = (data as! SettingsItemButton)
            cell.textLabel?.text = data.name
            
            if data.icon == "" {
                cell.textLabel?.textAlignment = .center
                cell.textLabel?.textColor = UIColor.red
            }
            else {
                cell.textLabel?.textAlignment = .left
                cell.textLabel?.textColor = UIColor.black
                cell.imageView?.image = UIImage(named: (data as! SettingsItemButton).icon)
            }
        }
        
        // Return the cell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get the data
        var data = self.dataSource[indexPath.section][indexPath.row]
        
        // Navigational items
        if data.type == .Navigation {
            // Get the class source
            let className: String! = (data as! SettingsItemNavigation).className
            
            // Combine the app and class names
            let appClassName = "Bees_Knees" + "." + className
            
            // Get the class object
            let classObj = NSClassFromString(appClassName) as! UIViewController.Type
            let vc = classObj.init()
            vc.title = NSLocalizedString((data as! SettingsItemNavigation).header, comment: "")
            
            // Push this view controller
            self.navigationController?.pushViewController(vc, animated: true)
        }
        // Button items
        else if data.type == .Button {
            // Trigger the action
            (data as! SettingsItemButton).action()
        }
    }
}

extension SettingsViewController: ORKTaskViewControllerDelegate {
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        // Check for Passcode task
        if taskViewController.title?.localizedCompare("Protect").rawValue == 0 {
            if reason == .completed {
                taskViewController.dismiss(animated: true, completion: nil)
            }
            else if reason == .discarded {
                taskViewController.dismiss(animated: true, completion: nil)
            }
        }
    }
}

extension SettingsViewController: ORKPasscodeDelegate {
    func passcodeViewControllerDidFinish(withSuccess viewController: UIViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func passcodeViewControllerDidFailAuthentication(_ viewController: UIViewController) {
    }
    
    func passcodeViewControllerDidCancel(_ viewController: UIViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
}
