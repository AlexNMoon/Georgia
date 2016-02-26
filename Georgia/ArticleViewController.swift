//
//  ArticleView.swift
//  Georgia
//
//  Created by MOZI Development on 10/13/15.
//  Copyright (c) 2015 MOZI Development. All rights reserved.
//

import UIKit
import SwiftyJSON
import AVFoundation

class ArticleViewController: UIViewController {
    
    var article: Article!
    
    let dataManager = DataManager()
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var text: String!
    
    @IBOutlet weak var articleTextWebView: UIWebView!
    
    @IBOutlet weak var textWebViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var publishersLogo: UIImageView!
    
    @IBOutlet weak var publishersName: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var articleTitle: UILabel!
   
    @IBOutlet weak var goToWebsiteButtonHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var goToWebSiteButton: UIButton!
    
    @IBOutlet weak var webView: UIWebView!
    
    @IBOutlet weak var webViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tapBarButtonItem: UIBarButtonItem!
    let defoultImage = UIImage(named: "launch_logo")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIBarButtonItem(image: UIImage(named: "feed_back_button"), style: .Plain, target: self, action: "closeView")
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.setHidesBackButton(false, animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.barTintColor = UIColor.redColor()
        self.date.textColor = UIColor.lightGrayColor()
        self.dataManager.getText(self.article.articleId.integerValue, completionHandler: {(data: JSON?) -> Void in
            if let text = data!["full_description"].string {
                dispatch_async(dispatch_get_main_queue(), {() -> Void in
                    self.text = text
                    self.articleTextWebView.loadHTMLString(self.text, baseURL: nil)
                    let size = self.articleTextWebView.sizeThatFits(CGSizeMake(self.articleTextWebView.frame.size.width,  CGFloat.max))
                    self.textWebViewHeightConstraint.constant = size.height
                })
            }
        })
        if let logo = self.article.publisher.logo {
            self.publishersLogo.sd_setImageWithURL(NSURL(string: logo))
            if self.publishersLogo.image == nil {
                self.publishersLogo.image = self.defoultImage
            }
        } else {
            self.publishersLogo.image = self.defoultImage
        }
        if let name = self.article.publisher.name {
            self.publishersName.text = name
        }
        if let title = self.article.title {
            self.articleTitle.text = title
            self.navigationItem.title = title
        }
        if let videoUrl = self.article.video {
            let videoEmbed = videoUrl.stringByReplacingOccurrencesOfString("watch?v=", withString: "embed/")
            let videoEmbedURL = NSURL(string: videoEmbed)
            let request = NSURLRequest(URL: videoEmbedURL!)
            self.webView.loadRequest(request)
        } else {
            if let _ = self.article.image {
                self.image.contentMode = .ScaleAspectFit
                self.image.image = UIImage(named: "publishers_add_icon")
                self.webViewHeightConstraint.constant = 0.0
            } else {
                self.hideImageView()
            }
        }
        if (self.article.link == nil) || (self.article.link == "") {
            self.goToWebsiteButtonHeightConstraint.constant = 0.0
            self.goToWebSiteButton.enabled = false
            self.goToWebSiteButton.setTitle("", forState: UIControlState.Normal)
        }
        if let time = article.publisherTime {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateStyle = NSDateFormatterStyle.FullStyle
            dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
            let date = NSDate(timeIntervalSince1970: time.doubleValue)
            self.date.text = dateFormatter.stringFromDate(date)
        }

    }
    
    func hideImageView() {
        self.imageHeightConstraint.constant = 0.0
        self.webViewHeightConstraint.constant = 0.0
    }
    
    func closeView() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func tapGoTOWebSite(sender: AnyObject) {
        if let url = self.article.link {
            UIApplication.sharedApplication().openURL(NSURL(string: url)!)
        }
    }
    
    @IBAction func tapShare(sender: AnyObject) {
        var sharingItems = [AnyObject]()
        if let title = self.articleTitle.text {
            sharingItems.append(title)
        }
        if let text = self.text {
            sharingItems.append(text)
        }
        if let image = self.image.image {
            sharingItems.append(image)
        }
        if let link = self.article.link {
            sharingItems.append(link)
        }
        let activityViewController = UIActivityViewController(activityItems: sharingItems, applicationActivities: nil)
        activityViewController.popoverPresentationController?.barButtonItem = self.tapBarButtonItem
        
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }
}
