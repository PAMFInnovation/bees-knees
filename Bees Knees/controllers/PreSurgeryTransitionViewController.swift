//
//  PreSurgeryTransitionViewController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 10/26/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit


protocol PreSurgeryTransitionDelegate: class {
    func setSurgeryButtonPressed(sender: PreSurgeryTransitionViewController)
    func goToCareCardButtonPressed(sender: PreSurgeryTransitionViewController)
}

class PreSurgeryTransitionViewController: UIViewController {
    
    // Button delegates
    var delegate: PreSurgeryTransitionDelegate?
    
    // Reference to the icon so we can change its color
    @IBOutlet weak var icon: UIImageView!
    
    
    
    // MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Set the color of the icon
        icon.image = icon.image?.withRenderingMode(.alwaysTemplate)
    }
    
    
    // MARK: - UI buttons
    @IBAction func setSurgeryDateButtonPressed(_ sender: UIButton) {
        // Replace back button with "Back" instead of long title it inherits
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        self.navigationItem.backBarButtonItem = backItem
        
        delegate?.setSurgeryButtonPressed(sender: self)
    }
    
    @IBAction func goToCareCardButtonPressed(_ sender: UIButton) {
        delegate?.goToCareCardButtonPressed(sender: self)
    }
}
