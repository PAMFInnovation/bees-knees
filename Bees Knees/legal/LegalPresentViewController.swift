//
//  LegalPresentViewController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 1/29/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import UIKit


class LegalPresentViewController: LegalViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 60))
        self.view.addSubview(navBar);
        let navItem = UINavigationItem(title: "");
        let closeButton = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(LegalPresentViewController.close))
        navItem.rightBarButtonItem = closeButton;
        navBar.setItems([navItem], animated: false);
        
        webView.frame = CGRect(x: webView.frame.origin.x, y: webView.frame.origin.y + 60, width: webView.frame.width, height: webView.frame.height - 60)
    }
    
    func close() {
        self.dismiss(animated: true, completion: nil)
    }
}
