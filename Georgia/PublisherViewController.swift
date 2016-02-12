//
//  PublisherView.swift
//  Georgia
//
//  Created by MOZI Development on 10/6/15.
//  Copyright (c) 2015 MOZI Development. All rights reserved.
//

import UIKit
import CoreData
import MessageUI

class PublisherViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    var publisher: Publisher!
   
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var logo: UIImageView!
    
    @IBOutlet weak var address: UILabel!
    
    @IBOutlet weak var mail: UILabel!
    
    @IBOutlet weak var phone: UILabel!
    
    @IBOutlet weak var text: UITextView!
    
    @IBOutlet weak var scrollViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var siteButtonWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var textHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var liveButtonWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var siteButtonHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var liveButtonHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var liveButton: UIButton!
    
    @IBOutlet weak var siteButton: UIButton!
    
    @IBOutlet weak var feedbackButton: UIButton!
    
    @IBOutlet weak var feedbackBottomLayoutCuide: NSLayoutConstraint!
    
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
            if self.logo.image != nil {
                let imageRect = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 120, height: 120))
                self.text.textContainer.exclusionPaths = [imageRect]
            }
            self.text.addSubview(self.logo)
        }
        if let name = publisher.name {
            self.name.text = name
            self.navigationItem.title = name
        }
        if let text = publisher.publDescription {
            self.text.text = text
            let size = self.text.sizeThatFits(CGSizeMake(self.text.frame.size.width,  CGFloat.max))
            if self.logo.image != nil {
                if size.height > 125.0 {
                    self.textHeightConstraint.constant = size.height
                } else {
                    self.textHeightConstraint.constant = 125.0
                }
            } else {
                if self.publisher.publDescription == "" {
                    self.textHeightConstraint.constant = 0.0
                } else {
                    self.textHeightConstraint.constant = size.height
                }
            }
        }
        if let address = publisher.address {
            self.address.text = address
        }
        if let mail = publisher.email {
            self.mail.text = mail
        }
        if let phone = publisher.telephone {
            self.phone.text = phone
        }
        if (self.publisher.site == nil) || (self.publisher.site == "") {
            self.siteButton.enabled = false
            self.siteButton.setTitle("", forState: UIControlState.Normal)
        }
        if (self.publisher.stream == nil) || (self.publisher.stream == "") {
            self.liveButton.enabled = false
            self.liveButton.setTitle("", forState: UIControlState.Normal)
        }
        if (!self.siteButton.enabled) && (!self.liveButton.enabled) {
            self.liveButtonHeightConstraint.constant = 0.0
            self.siteButtonHeightConstraint.constant = 0.0
            self.feedbackBottomLayoutCuide.constant = 0.0
        } else {
            if (self.siteButton.enabled) && (self.liveButton.enabled) {
                self.liveButtonWidthConstraint.constant = self.view.frame.width / 2.0 + 10.0
                self.siteButtonWidthConstraint.constant = self.liveButtonWidthConstraint.constant
            } else {
                if self.siteButton.enabled {
                    self.liveButtonWidthConstraint.constant = 0.0
                    self.siteButtonWidthConstraint.constant = self.view.frame.width + 20.0
                } else {
                    self.siteButtonWidthConstraint.constant = 0.0
                    self.liveButtonWidthConstraint.constant = self.view.frame.width + 20.0
                }
            }
        }
    }
    
    @IBAction func tapGoToWebSiteButton(sender: AnyObject) {
        if let url = self.publisher.site {
            UIApplication.sharedApplication().openURL(NSURL(string: url)!)
        }
    }
    
    @IBAction func tapFeedback(sender: AnyObject) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    @IBAction func tapLive(sender: AnyObject) {
        if let url = self.publisher.stream {
            UIApplication.sharedApplication().openURL(NSURL(string: url)!)
        }
    }
    
    @IBAction func tapMail(sender: AnyObject) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
        mailComposeViewController.setToRecipients([self.publisher.email!])
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    @IBAction func tapPhone(sender: AnyObject) {
        if let phone = self.publisher.telephone {
            let url = "tel://" + phone.stringByReplacingOccurrencesOfString(" ", withString: "", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
            UIApplication.sharedApplication().openURL(NSURL(string: url)!)
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["blabla@gmail.com"])
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", preferredStyle: UIAlertControllerStyle.Alert)
        self.presentViewController(sendMailErrorAlert, animated: true, completion: nil)
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
