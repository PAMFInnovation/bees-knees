//
//  ImageViewController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/16/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit


class ImageViewController: UIViewController {
    
    var imageScrollView: ImageScrollView!
    
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
        
        showImage()
    }
    
    private func showImage() {
        guard let path = Bundle.main.path(forResource: file, ofType: type) else {
            print("Image file not found")
            return
        }
        
        let rect = CGRect(x: 0, y: 60, width: self.view.frame.width, height: self.view.frame.height - 109)
        
        imageScrollView = ImageScrollView(frame: rect)
        self.view.addSubview(imageScrollView)
        
        let myImage = UIImage(contentsOfFile: path)
        imageScrollView.display(image: myImage!)
    }
}
