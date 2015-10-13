//
//  PublisherView.swift
//  Georgia
//
//  Created by MOZI Development on 10/6/15.
//  Copyright (c) 2015 MOZI Development. All rights reserved.
//

import UIKit

class PublisherView: UIViewController {
    
    let dataManager = DataManager()
   
    @IBOutlet weak var text: UITextView!
    
    override func viewDidLoad() {
        dataManager.getText({ (text: String) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.text.text = text
            })
        })
        var backButton = UIBarButtonItem(image: UIImage(named: "filters_close_button@3x.png"), style: .Plain, target: self, action: "closeView")
        self.navigationItem.rightBarButtonItem = backButton
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    func closeView() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.barTintColor = UIColor.redColor()
    }

}
