//
//  VideoViewController.swift
//  Bees Knees
//
//  Created by Ben Dapkiewicz on 11/15/16.
//  Copyright © 2016 Sutter Health. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation


class VideoViewController: UIViewController {
    
    var player: AVPlayer?
    
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.showVideo()
    }
    
    private func showVideo() {
        guard let path = Bundle.main.path(forResource: file, ofType: type) else {
            print("Video file not found")
            return
        }
        
        // Create the video player and attach it to an AV player controller
        player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerController = AVPlayerViewController()
        playerController.player = player
        // Offset the frame by the height of the nav bar (60) and the height of the tab bar (49)
        let videoFrame = CGRect(x: 0, y: 60, width: self.view.frame.width, height: self.view.frame.height - 109)
        playerController.view.frame =  videoFrame
        playerController.showsPlaybackControls = true
        
        // Add the AV controller as a subview
        self.addChildViewController(playerController)
        self.view.addSubview(playerController.view)
    }
}
