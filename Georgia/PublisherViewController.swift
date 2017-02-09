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
        let backButton = UIBarButtonItem(image: UIImage(named: "filters_close_button"), style: .plain, target: self, action: #selector(PublisherViewController.closeView))
        self.navigationItem.rightBarButtonItem = backButton
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    func closeView() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.barTintColor = UIColor.red
        if let logoUrl = publisher.logo {
            self.logo.sd_setImage(with: URL(string: logoUrl))
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
            let size = self.text.sizeThatFits(CGSize(width: self.text.frame.size.width,  height: CGFloat.greatestFiniteMagnitude))
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
            self.siteButton.isEnabled = false
            self.siteButton.setTitle("", for: UIControlState())
        }
        if (self.publisher.stream == nil) || (self.publisher.stream == "") {
            self.liveButton.isEnabled = false
            self.liveButton.setTitle("", for: UIControlState())
        }
        if (!self.siteButton.isEnabled) && (!self.liveButton.isEnabled) {
            self.liveButtonHeightConstraint.constant = 0.0
            self.siteButtonHeightConstraint.constant = 0.0
            self.feedbackBottomLayoutCuide.constant = 0.0
        } else {
            if (self.siteButton.isEnabled) && (self.liveButton.isEnabled) {
                self.liveButtonWidthConstraint.constant = self.view.frame.width / 2.0 + 10.0
                self.siteButtonWidthConstraint.constant = self.liveButtonWidthConstraint.constant
            } else {
                if self.siteButton.isEnabled {
                    self.liveButtonWidthConstraint.constant = 0.0
                    self.siteButtonWidthConstraint.constant = self.view.frame.width + 20.0
                } else {
                    self.siteButtonWidthConstraint.constant = 0.0
                    self.liveButtonWidthConstraint.constant = self.view.frame.width + 20.0
                }
            }
        }
    }
    
    @IBAction func tapGoToWebSiteButton(_ sender: AnyObject) {
        if let url = self.publisher.site {
            UIApplication.shared.openURL(URL(string: url)!)
        }
    }
    
    @IBAction func tapFeedback(_ sender: AnyObject) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    @IBAction func tapLive(_ sender: AnyObject) {
        if let url = self.publisher.stream {
            UIApplication.shared.openURL(URL(string: url)!)
        }
    }
    
    @IBAction func tapMail(_ sender: AnyObject) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
        mailComposeViewController.setToRecipients([self.publisher.email!])
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    @IBAction func tapPhone(_ sender: AnyObject) {
        if let phone = self.publisher.telephone {
            let url = "tel://" + phone.replacingOccurrences(of: " ", with: "", options: NSString.CompareOptions.caseInsensitive, range: nil)
            UIApplication.shared.openURL(URL(string: url)!)
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["blabla@gmail.com"])
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", preferredStyle: UIAlertControllerStyle.alert)
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}
