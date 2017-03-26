//
//  WelcomeLocationViewController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 3/25/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import UIKit


class WelcomeLocationViewController: WelcomeTaskViewController {
    
    var continueButton: CustomButton?
    var previouslySelectedRow: Int = 0
    
    
    // MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the location picker view
        let locationPickerView: UIPickerView = UIPickerView()
        locationPickerView.dataSource = self
        locationPickerView.delegate = self
        locationPickerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(locationPickerView)
        self.view.addConstraint(NSLayoutConstraint(item: locationPickerView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: locationPickerView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: -100))
        self.view.addConstraint(NSLayoutConstraint(item: locationPickerView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 240))
        self.view.addConstraint(NSLayoutConstraint(item: locationPickerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 200))
        
        // Setup the continue button
        continueButton = CustomButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0), primaryColor: UIColor.white, secondaryColor: UIColor.clear, disabledColor: UIColor.lightGray, textDownColor: Colors.turquoise.color)
        continueButton?.borderColor = UIColor.white
        continueButton?.borderWidth = 1
        continueButton?.cornerRadius = 5
        continueButton?.titleLabel?.textAlignment = .center
        continueButton?.setTitle("Continue", for: .normal)
        continueButton?.isEnabled = false
        continueButton?.addTarget(self, action: #selector(WelcomeLocationViewController.complete), for: .touchUpInside)
        continueButton?.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(continueButton!)
        self.view.addConstraint(NSLayoutConstraint(item: continueButton!, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: continueButton!, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: -20))
        self.view.addConstraint(NSLayoutConstraint(item: continueButton!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 160))
        self.view.addConstraint(NSLayoutConstraint(item: continueButton!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50))
        
        // Set default picker cell if it's saved
        let userLocation = ProfileManager.sharedInstance.getSurgeryLocation()
        let locations = ProfileManager.sharedInstance.getLocations()
        for (index, location) in locations.enumerated() {
            if location.key == userLocation {
                locationPickerView.selectRow(index + 1, inComponent: 0, animated: true)
                continueButton?.isEnabled = true
            }
        }
    }
    
    
    // MARK: - Helper functions
    func complete() {
        delegate?.completeTask(sender: self)
    }
}

extension WelcomeLocationViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ProfileManager.sharedInstance.getLocations().count + 1
    }
}

extension WelcomeLocationViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var name = "Please select..."
        
        if row > 0 {
            let locations = ProfileManager.sharedInstance.getLocations()
            name = locations[row - 1].name
        }
        
        return NSAttributedString(string: name, attributes: [NSForegroundColorAttributeName: UIColor.white])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {
            pickerView.selectRow(previouslySelectedRow, inComponent: 0, animated: true)
        }
        else {
            continueButton?.isEnabled = true
            
            let locations = ProfileManager.sharedInstance.getLocations()
            let selectedLocation = locations[row - 1].key
            ProfileManager.sharedInstance.setSurgeryLocation(selectedLocation)
            
            
            previouslySelectedRow = row
        }
    }
}
