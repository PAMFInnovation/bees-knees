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
        
        self.view.backgroundColor = UIColor.white
        
        webView = UIWebView(frame: self.view.frame)
        self.view.addSubview(webView)
        
        (ProfileManager.sharedInstance.consent as! ORKConsentDocument).makePDF(completionHandler:{ (data: Data?, error: Error?) in
            self.webView.load(data!, mimeType: "application/pdf", textEncodingName: "UTF-8", baseURL: NSURL() as URL)
        })
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
