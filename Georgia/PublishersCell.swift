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
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    
    var selectAll: UIBarButtonItem!

    @IBOutlet weak var addPublisher: UIButton!
    
    @IBOutlet weak var logo: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    let add = UIImage(named: "publishers_add_icon")
    
    let added = UIImage(named: "publishers_added_icon")
    
    let defoultImage = UIImage(named: "launch_logo")
    
    var publisher: Publisher!
    
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!
    
    let dataManager = DataManager()

    @IBAction func tapAddPublisherButton(_ sender: AnyObject) {
        if publisher.isSelected == 1 {
            self.publisherUnselectedCoreData()
        } else {
            self.publisherSelectedCoreData()
        }
        self.dataManager.getArticles()
    }
    
    func setParameters(_ publisher: Publisher, fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>, selectAll: UIBarButtonItem) {
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
            self.logo.sd_setImage(with: URL(string: logoUrl))
            if self.logo.image == nil {
                self.logo.image = self.defoultImage
            }
        }
        if let name = publisher.name {
            self.name.text = name
        }
    }
    
    func publisherIsSelected() {
        addPublisher.setImage(added, for: UIControlState())
        addPublisher.tintColor = UIColor.gray
        addPublisher.imageEdgeInsets = UIEdgeInsetsMake(0, addPublisher.frame.size.width - (added!.size.width), 0, 0)
    }
    
    func publiserIsUnselected() {
        addPublisher.setImage(add, for: UIControlState())
        addPublisher.tintColor = UIColor.cyan
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
