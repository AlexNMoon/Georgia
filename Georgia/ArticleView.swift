//
//  ArticleView.swift
//  Georgia
//
//  Created by MOZI Development on 10/13/15.
//  Copyright (c) 2015 MOZI Development. All rights reserved.
//

import UIKit

class ArticleView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var backButton = UIBarButtonItem(image: UIImage(named: "feed_back_button@3x.png"), style: .Plain, target: self, action: "closeView")
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.setHidesBackButton(false, animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.barTintColor = UIColor.redColor()
    }
    
    func closeView() {
        self.navigationController?.popViewControllerAnimated(true)
    }


}
