//
//  PublisherView.swift
//  Georgia
//
//  Created by MOZI Development on 10/6/15.
//  Copyright (c) 2015 MOZI Development. All rights reserved.
//

import UIKit
import CoreData

class PublisherViewController: UIViewController {
    
    var publisher: Publisher!
   
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var logo: UIImageView!
    
    @IBOutlet weak var address: UILabel!
    
    @IBOutlet weak var mail: UILabel!
    
    @IBOutlet weak var phone: UILabel!
    
    @IBOutlet weak var text: UITextView!
    
    @IBOutlet weak var scrollViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var textHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var liveButton: UIButton!
    
    @IBOutlet weak var siteButton: UIButton!
    
    @IBOutlet weak var feedbackButton: UIButton!
    
    override func viewDidLoad() {
        let backButton = UIBarButtonItem(image: UIImage(named: "filters_close_button"), style: .Plain, target: self, action: "closeView")
        self.navigationItem.rightBarButtonItem = backButton
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    func closeView() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.barTintColor = UIColor.redColor()
        if let logoUrl = publisher.logo {
            self.logo.sd_setImageWithURL(NSURL(string: logoUrl))
            let imageRect = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 120, height: 120))
            self.text.textContainer.exclusionPaths = [imageRect]
            self.text.addSubview(self.logo)
        }
        if let name = publisher.name {
            self.name.text = name
            self.navigationItem.title = name
        }
        if let text = publisher.publDescription {
            self.text.text = text
            let size = self.text.sizeThatFits(CGSizeMake(self.text.frame.size.width,  CGFloat.max))
            if size.height > CGFloat(120) {
                self.textHeightConstraint.constant = size.height
            } else {
                self.textHeightConstraint.constant = CGFloat(120)
            }
        }
        if let address = publisher.address {
            self.address.text = address
        }
        if let mail = publisher.email {
            self.mail.text = mail
        } else {
            self.feedbackButton.enabled = false
        }
        if let phone = publisher.telephone {
            self.phone.text = phone
        }
        if self.publisher.site == nil {
            self.siteButton.enabled = false
        }
        if self.publisher.stream == nil {
            self.liveButton.enabled = false
        }
        if self.feedbackButton.enabled == false {
            if (self.siteButton.enabled == false) && (self.liveButton.enabled == false) {
                self.scrollViewHeightConstraint.constant += CGFloat(64)
            } else {
                self.scrollViewHeightConstraint.constant += CGFloat(32)
            }
        }
    }
    
    @IBAction func tapGoToWebSiteButton(sender: AnyObject) {
        if let url = self.publisher.valueForKey("site") as? String {
            UIApplication.sharedApplication().openURL(NSURL(string: url)!)
        } else {
            print("there is no web site")
        }
    }
    
    @IBAction func tapFeedback(sender: AnyObject) {
    }
    
    @IBAction func tapLive(sender: AnyObject) {
    }
    
    @IBAction func tapMail(sender: AnyObject) {
    }
    
    @IBAction func tapPhone(sender: AnyObject) {
        if let phone = self.publisher.telephone {
            let url = "tel://" + phone.stringByReplacingOccurrencesOfString(" ", withString: "", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
            UIApplication.sharedApplication().openURL(NSURL(string: url)!)
        }
    }
    
}
