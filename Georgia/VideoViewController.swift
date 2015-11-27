//
//  VideoViewController.swift
//  Georgia
//
//  Created by MOZI Development on 11/27/15.
//  Copyright © 2015 MOZI Development. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class VideoViewController: AVPlayerViewController {
    
    var article: Article!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        let url = NSURL(string: self.article.video!)
        let player = AVPlayer(URL: url!)
        var playerViewController = AVPlayerViewController()
        playerViewController.player = player
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
}
