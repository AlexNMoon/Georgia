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
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    
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
        let backButton = UIBarButtonItem(image: UIImage(named: "feed_back_button"), style: .plain, target: self, action: #selector(ArticleViewController.closeView))
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.setHidesBackButton(false, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.barTintColor = UIColor.red
        self.date.textColor = UIColor.lightGray
        self.dataManager.getText(self.article.articleId.intValue, completionHandler: {(data: JSON?) -> Void in
            if let text = data!["full_description"].string {
                DispatchQueue.main.async(execute: {() -> Void in
                    self.text = text
                    self.articleTextWebView.loadHTMLString(self.text, baseURL: nil)
                    let size = self.articleTextWebView.sizeThatFits(CGSize(width: self.articleTextWebView.frame.size.width,  height: CGFloat.greatestFiniteMagnitude))
                    self.textWebViewHeightConstraint.constant = size.height
                })
            }
        })
        if let logo = self.article.publisher.logo {
            self.publishersLogo.sd_setImage(with: URL(string: logo))
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
            let videoEmbed = videoUrl.replacingOccurrences(of: "watch?v=", with: "embed/")
            let videoEmbedURL = URL(string: videoEmbed)
            let request = URLRequest(url: videoEmbedURL!)
            self.webView.loadRequest(request)
        } else {
            if let _ = self.article.image {
                self.image.contentMode = .scaleAspectFit
                self.image.image = UIImage(named: "publishers_add_icon")
                self.webViewHeightConstraint.constant = 0.0
            } else {
                self.hideImageView()
            }
        }
        if (self.article.link == nil) || (self.article.link == "") {
            self.goToWebsiteButtonHeightConstraint.constant = 0.0
            self.goToWebSiteButton.isEnabled = false
            self.goToWebSiteButton.setTitle("", for: UIControlState())
        }
        if let time = article.publisherTime {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = DateFormatter.Style.full
            dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
            let date = Date(timeIntervalSince1970: time.doubleValue)
            self.date.text = dateFormatter.string(from: date)
        }

    }
    
    func hideImageView() {
        self.imageHeightConstraint.constant = 0.0
        self.webViewHeightConstraint.constant = 0.0
    }
    
    func closeView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapGoTOWebSite(_ sender: AnyObject) {
        if let url = self.article.link {
            UIApplication.shared.openURL(URL(string: url)!)
        }
    }
    
    @IBAction func tapShare(_ sender: AnyObject) {
        var sharingItems = [AnyObject]()
        if let title = self.articleTitle.text {
            sharingItems.append(title as AnyObject)
        }
        if let text = self.text {
            sharingItems.append(text as AnyObject)
        }
        if let image = self.image.image {
            sharingItems.append(image)
        }
        if let link = self.article.link {
            sharingItems.append(link as AnyObject)
        }
        let activityViewController = UIActivityViewController(activityItems: sharingItems, applicationActivities: nil)
        activityViewController.popoverPresentationController?.barButtonItem = self.tapBarButtonItem
        
        self.present(activityViewController, animated: true, completion: nil)
    }
}
