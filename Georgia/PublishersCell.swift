//
//  PublishersCell.swift
//  Georgia
//
//  Created by MOZI Development on 9/30/15.
//  Copyright (c) 2015 MOZI Development. All rights reserved.
//

import UIKit
import CoreData

class PublishersCell: UITableViewCell {
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var selectAll: UIBarButtonItem!

    @IBOutlet weak var addPublisher: UIButton!
    
    @IBOutlet weak var logo: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    let add = UIImage(named: "publishers_add_icon@3x.png")
    
    let added = UIImage(named: "publishers_added_icon@3x.png")
    
    let new = UIImage(named: "publishers_new_icon@3x.png")
    
    var publisher: NSManagedObject!

    @IBAction func tapAddPublisherButton(sender: AnyObject) {
        if publisher.valueForKey("isSelected") as? Int == 1 {
            self.publiserIsUnselected()
            self.publisherUnselectedCoreData()
        } else {
            self.publisherIsSelected()
            self.publisherSelectedCoreData()
            if self.selectAll.title == "Select All" {
                self.selectAll.title = "Unselect All"
            }
        }
    }
    
    func setParametrs(publisher: NSManagedObject) {
        self.publisher = publisher
        if publisher.valueForKey("isSelected") as? Int == 0 {
            self.publiserIsUnselected()
        } else {
            if publisher.valueForKey("isSelected") as? Int == 1 {
                self.publisherIsSelected()
            }
        }
        if let logoUrl = publisher.valueForKey("logo") as? String {
            self.logo.sd_setImageWithURL(NSURL(string: logoUrl))
        }
        if let name = publisher.valueForKey("name") as? String {
            self.name.text = name
        }
    }
    
    func publisherIsSelected() {
        addPublisher.setImage(added, forState: UIControlState.Normal)
        addPublisher.tintColor = UIColor.grayColor()
        addPublisher.imageEdgeInsets = UIEdgeInsetsMake(0, addPublisher.frame.size.width - (added!.size.width), 0, 0)
    }
    
    func publiserIsUnselected() {
        addPublisher.setImage(add, forState: UIControlState.Normal)
        addPublisher.tintColor = UIColor.cyanColor()
        addPublisher.imageEdgeInsets = UIEdgeInsetsMake(0, addPublisher.frame.size.width - (add!.size.width), 0, 0)
    }
    
    func publisherSelectedCoreData() {
        publisher.setValue(1, forKey: "isSelected")
        managedObjectContext?.save(nil)
    }
    
    func publisherUnselectedCoreData() {
        publisher.setValue(0, forKey: "isSelected")
        managedObjectContext?.save(nil)
    }
    
}
