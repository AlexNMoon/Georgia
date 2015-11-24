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
    
    let add = UIImage(named: "publishers_add_icon")
    
    let added = UIImage(named: "publishers_added_icon")
    
    let new = UIImage(named: "publishers_new_icon")
    
    var publisher: Publisher!
    
    var fetchedResultsController: NSFetchedResultsController!

    @IBAction func tapAddPublisherButton(sender: AnyObject) {
        if publisher.isSelected == 1 {
            self.publisherUnselectedCoreData()
        } else {
            self.publisherSelectedCoreData()
        }
    }
    
    func setParameters(publisher: Publisher, fetchedResultsController: NSFetchedResultsController, selectAll: UIBarButtonItem) {
        self.publisher = publisher
        self.fetchedResultsController = fetchedResultsController
        self.selectAll = selectAll
        if publisher.isSelected == 1 {
            self.publisherIsSelected()
        } else {
            if publisher.isSelected == 0 {
                self.publiserIsUnselected()
            }
        }
        if let logoUrl = publisher.logo {
            self.logo.sd_setImageWithURL(NSURL(string: logoUrl))
        }
        if let name = publisher.name {
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
        publisher.isSelected = 1
        do {
            try managedObjectContext?.save()
        } catch _ {
        }
    }
    
    func publisherUnselectedCoreData() {
        publisher.isSelected = 0
        do {
            try managedObjectContext?.save()
        } catch _ {
        }
    }
    
}
