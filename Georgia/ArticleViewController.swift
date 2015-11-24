//
//  ArticleView.swift
//  Georgia
//
//  Created by MOZI Development on 10/13/15.
//  Copyright (c) 2015 MOZI Development. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {
    
    var article: Article!
    
    @IBOutlet weak var articleText: UITextView!
    
    @IBOutlet weak var textHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var publishersLogoWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var publishersLogo: UIImageView!
    
    @IBOutlet weak var publishersName: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var articleTitle: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIBarButtonItem(image: UIImage(named: "feed_back_button"), style: .Plain, target: self, action: "closeView")
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.setHidesBackButton(false, animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.barTintColor = UIColor.redColor()
        if let text = self.article.text {
            self.articleText.text = text
            let size = self.articleText.sizeThatFits(CGSizeMake(self.articleText.frame.size.width,  CGFloat.max))
            self.textHeightConstraint.constant = size.height
        }
        if let logo = self.article.publisher.logo {
            self.publishersLogo.sd_setImageWithURL(NSURL(string: logo))
        } else {
            self.publishersLogoWidthConstraint.constant = 0.0
        }
        if let name = self.article.publisher.name {
            self.publishersName.text = name
        }
        if let title = self.article.title {
            self.articleTitle.text = title
        }
        if let videoUrl = self.article.video {
            
        } else {
            if let imageUrl = self.article.image {
                self.image.sd_setImageWithURL(NSURL(string: imageUrl))
            } else {
                self.imageHeightConstraint.constant = 0.0
            }
        }
    }
    
    func closeView() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func tapGoTOWebSite(sender: AnyObject) {
        if let url = self.article.link {
            UIApplication.sharedApplication().openURL(NSURL(string: url)!)
        }
    }
    
}
