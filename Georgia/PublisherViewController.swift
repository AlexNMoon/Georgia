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
    
    @IBOutlet weak var textHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var siteButtonWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var liveButtonWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var siteButtonHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var liveButtonHeightConstraint: NSLayoutConstraint!
    
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
        }
        if let phone = publisher.telephone {
            self.phone.text = phone
        }
        if self.publisher.site == nil {
            self.siteButton.enabled = false
            self.siteButtonWidthConstraint.constant = CGFloat(0)
            self.liveButtonWidthConstraint.constant = self.view.frame.width + 20.0
        }
        if self.publisher.stream == nil {
            self.liveButton.enabled = false
            self.liveButtonWidthConstraint.constant = CGFloat(0)
            self.siteButtonWidthConstraint.constant = self.view.frame.width + 20.0
        }
        if (self.siteButton.enabled == false) && (self.liveButton.enabled == false) {
            self.liveButtonHeightConstraint.constant = CGFloat(0)
            self.siteButtonHeightConstraint.constant = CGFloat(0)
        } else {
            if (self.siteButton.enabled == true) && (self.liveButton.enabled == true) {
                self.liveButtonWidthConstraint.constant = self.view.frame.width / 2.0 + 10.0
                self.siteButtonWidthConstraint.constant = self.liveButtonWidthConstraint.constant
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
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
