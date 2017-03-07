//
//  DocViewController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/15/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit


class DocViewController: UIViewController {
    
    var webView: UIWebView!
    
    var file: String!
    var type: String!
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init(file: String, type: String) {
        self.init(nibName: nil, bundle: nil)
        
        self.file = file
        self.type = type
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        showDoc()
    }
    
    private func showDoc() {
        guard let path = Bundle.main.path(forResource: file, ofType: type) else {
            print("Doc file not found")
            return
        }
        
        webView = UIWebView(frame: self.view.frame)
        self.view.addSubview(webView)
        
        let url: NSURL = NSURL(fileURLWithPath: path)
        let request = NSURLRequest(url: url as URL)
        webView.loadRequest(request as URLRequest)
    }
}
