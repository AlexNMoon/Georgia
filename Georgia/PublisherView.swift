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
   
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var logo: UIImageView!
    
    @IBOutlet weak var address: UILabel!
    
    @IBOutlet weak var mail: UILabel!
    
    @IBOutlet weak var phone: UILabel!
    
    @IBOutlet weak var text: UITextView!
    
    @IBOutlet weak var textHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        dataManager.getPublishers(0, completionHandler: {(id: Int, name: String, logoUrl: String) -> Void in
            dispatch_async(dispatch_get_main_queue(), {() -> Void in
                self.name.text = name
                self.logo.sd_setImageWithURL(NSURL(string: logoUrl))
            })
        })
        dataManager.getText({ (text: String) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.text.text = text
                let size = self.text.sizeThatFits(CGSizeMake(self.text.frame.size.width,  CGFloat.max))
                self.textHeightConstraint.constant = size.height
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
