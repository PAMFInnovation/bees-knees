//
//  DateOfSurgeryPresentViewController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 1/30/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import UIKit


protocol DateOfSurgeryPresentViewControllerDelegate: class {
    func complete(sender: DateOfSurgeryPresentViewController)
}

class DateOfSurgeryPresentViewController: DateOfSurgeryViewController {
    
    weak var delegate: DateOfSurgeryPresentViewControllerDelegate?
    var navBar: UINavigationBar?
    var closeTitle: String = "Done"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 60))
        self.view.addSubview(navBar!);
        let navItem = UINavigationItem(title: "Date of Surgery");
        let closeButton = UIBarButtonItem(title: closeTitle, style: .done, target: self, action: #selector(DateOfSurgeryPresentViewController.close))
        navItem.rightBarButtonItem = closeButton;
        navBar?.setItems([navItem], animated: false);
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navBar?.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 60)
    }
    
    func close() {
        self.delegate?.complete(sender: self)
    }
}
