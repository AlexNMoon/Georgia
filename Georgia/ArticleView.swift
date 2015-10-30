//
//  ArticleView.swift
//  Georgia
//
//  Created by MOZI Development on 10/13/15.
//  Copyright (c) 2015 MOZI Development. All rights reserved.
//

import UIKit

class ArticleView: UIViewController {
    
    let dataManager = DataManager()
    
    @IBOutlet weak var articleText: UITextView!
    
    @IBOutlet weak var textHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       /* dataManager.getText({ (text: String) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.articleText.text = text
                let size = self.articleText.sizeThatFits(CGSize(width: self.articleText.frame.size.width, height: CGFloat.max))
                self.textHeightConstraint.constant = size.height
            })
        })*/
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
