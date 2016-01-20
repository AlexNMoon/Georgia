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
    
    let stringEncoding = StringEncoding()
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var text: String!
    
    @IBOutlet weak var articleText: UITextView!
    
    @IBOutlet weak var textHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var publishersLogoWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var publishersLogo: UIImageView!
    
    @IBOutlet weak var publishersName: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var articleTitle: UILabel!
   
    @IBOutlet weak var goToWebsiteButtonHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var goToWebSiteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIBarButtonItem(image: UIImage(named: "feed_back_button"), style: .Plain, target: self, action: "closeView")
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.setHidesBackButton(false, animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.barTintColor = UIColor.redColor()
        self.dataManager.getText(self.article.articleId.integerValue, completionHandler: {(data: JSON?) -> Void in
            if let text = data!["full_description"].string {
                dispatch_async(dispatch_get_main_queue(), {() -> Void in
                    self.text = self.stringEncoding.encoding(text)
                    self.articleText.text = self.text
                    let size = self.articleText.sizeThatFits(CGSizeMake(self.articleText.frame.size.width,  CGFloat.max))
                    self.textHeightConstraint.constant = size.height
                })
            }
        })
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
      //  let id = self.article.category.categoriesId
        if let videoUrl = self.article.video {
            let vidURL = NSURL(string: videoUrl)
            let asset = AVURLAsset(URL: vidURL!)
            let generator = AVAssetImageGenerator(asset: asset)
            generator.appliesPreferredTrackTransform = true
            var time = asset.duration
            time.value = min(time.value, 2)
            do {
                let imageRef = try generator.copyCGImageAtTime(time, actualTime: nil)
                self.image.image = UIImage(CGImage: imageRef)
            }
            catch let error as NSError
            {
                print("Image generation failed with error \(error)")
            }
        } else {
            if let imageUrl = self.article.image {
                self.image.sd_setImageWithURL(NSURL(string: imageUrl))
            } else {
                self.imageHeightConstraint.constant = 0.0
            }
        }
        if (self.article.link == nil) || (self.article.link == "") {
            self.goToWebsiteButtonHeightConstraint.constant = 0.0
            self.goToWebSiteButton.enabled = false
            self.goToWebSiteButton.setTitle("", forState: UIControlState.Normal)
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
    
    @IBAction func tapShare(sender: AnyObject) {
        var sharingItems = [AnyObject]()
        if let title = self.articleTitle.text {
            sharingItems.append(title)
        }
        if let text = self.articleText.text {
            sharingItems.append(text)
        }
        if let image = self.image.image {
            sharingItems.append(image)
        }
        if let link = self.article.link {
            sharingItems.append(link)
        }
        let activityViewController = UIActivityViewController(activityItems: sharingItems, applicationActivities: nil)
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }
}
