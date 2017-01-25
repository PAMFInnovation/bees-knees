//
//  ResourceViewController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 1/19/17.
//  Copyright © 2017 Sutter Health. All rights reserved.
//

import UIKit


class ResourceViewController: UIViewController {
    
    // MARK: - Properties
    let htmlFile: String
    var webView: UIWebView = UIWebView()
    var webViewCenter: CGPoint = CGPoint.zero
    var isTrackingPanLocation: Bool = false
    
    
    // MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        self.htmlFile = ""
        fatalError("init(coder:) has not been implemented")
    }
    
    init(htmlFile: String) {
        self.htmlFile = htmlFile
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // White background color
        self.view.backgroundColor = UIColor.white
        
        // Rounded upper corners
        self.view.roundCorners(corners: [.topLeft, .topRight], radius: 20)
        
        // Setup the webview
        let yOffset: CGFloat = 20
        self.webView = UIWebView(frame: CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y + yOffset, width: self.view.frame.width, height: self.view.frame.height - 60 - yOffset))
        webView.backgroundColor = UIColor.white
        webView.scalesPageToFit = true
        self.view.addSubview(webView)
        
        // Load the html file
        let file = Bundle.main.path(forResource: self.htmlFile, ofType: "html")
        let html = try? String(contentsOfFile: file!, encoding: String.Encoding.utf8)
        
        // Construct base HTML with standard styling
        var finalHtml = "<html><head><style>body {font-family: Arial, Helvetica, sans-serif;font-size: 40px;margin: 60px 60px;} img {width: 100%;}</style></head>"
        
        // If the HTML file does not exist, display an error message
        if html == nil || self.htmlFile == "" {
            finalHtml.append("<body><h2>Content Not Found</h2><p>Attempted to load Binder content that was not found.</p></body>")
        }
        // Else, append the loaded HTML
        else {
            finalHtml.append(html!)
        }
        
        // Close the HTMl with the final tag
        finalHtml.append("</html>")
        
        // Load the HTML into the webview
        webView.loadHTMLString(finalHtml, baseURL: Bundle.main.bundleURL)
        webViewCenter = webView.center
        
        // Listen for pan gesture
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(ResourceViewController.panRecognized))
        panGestureRecognizer.delegate = self
        self.view.addGestureRecognizer(panGestureRecognizer)
    }
    
    public func panRecognized(recognizer: UIPanGestureRecognizer) {
        // Only track panning of the resource view if the webview is
        // scrolled to the top
        if recognizer.state == .began {
            isTrackingPanLocation = false
            webViewCenter = recognizer.view!.center
        }
        // Check for panning the main view
        else if recognizer.state != .ended &&
            recognizer.state != .cancelled &&
            recognizer.state != .failed &&
            isTrackingPanLocation {
            
            // Pan the view in y dimension but never let it pan upward past it's current center
            let panOffset = recognizer.translation(in: self.view)
            if recognizer.view!.center.y >= webViewCenter.y {
                recognizer.view!.center = CGPoint(x: recognizer.view!.center.x, y: CGFloat.maximum(webViewCenter.y, recognizer.view!.center.y + panOffset.y))
                recognizer.setTranslation(CGPoint.zero, in: self.view)
                self.webView.scrollView.contentOffset.y = 0
            }
            
            // If the y scroll delta reaches a certain threshold, dismiss the controller
            if recognizer.view!.center.y - webViewCenter.y >= 130 {
                recognizer.isEnabled = false
                recognizer.isEnabled = true
                self.dismiss(animated: true, completion: nil)
            }
        }
        else if recognizer.state == .ended ||
            recognizer.state == .cancelled ||
            recognizer.state == .failed {
            isTrackingPanLocation = false
            UIView.animate(withDuration: 0.2, animations: {
                recognizer.view!.center = self.webViewCenter
            })
        }
        
        if isTrackingPanLocation == false &&
            self.webView.scrollView.contentOffset.y <= 0 {
            isTrackingPanLocation = true
            recognizer.setTranslation(CGPoint.zero, in: self.view)
        }
    }
}

extension ResourceViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
