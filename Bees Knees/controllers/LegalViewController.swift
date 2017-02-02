//
//  LegalViewController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/4/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit
import CareKit
import ResearchKit


class LegalViewController: UIViewController {
    
    var webView: UIWebView!
    
    
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
        
        guard let consentData = ProfileManager.sharedInstance.getSignedConsentDocument() else {
            return
        }
        
        self.view.backgroundColor = UIColor.white
        
        webView = UIWebView(frame: self.view.frame)
        self.view.addSubview(webView)
        
        self.webView.load(consentData, mimeType: "application/pdf", textEncodingName: "UTF-8", baseURL: URL(string: "http://www.stackoverflow.com")!)// NSURL() as URL)// nil)// NSURL() as URL)
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
}
