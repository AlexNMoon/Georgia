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

    @IBOutlet weak var addPublisher: UIButton!
    
    @IBOutlet weak var logo: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    var addedPublisher: Bool = false
    
    let add = UIImage(named: "publishers_add_icon@3x.png")
    
    let added = UIImage(named: "publishers_added_icon@3x.png")
    
    let new = UIImage(named: "publishers_new_icon@3x.png")

    
    @IBAction func tapAddPublisherButton(sender: AnyObject) {
        addPublisher.setBackgroundImage(nil, forState: UIControlState.Normal)
        if addedPublisher {
            addPublisher.setImage(add, forState: UIControlState.Normal)
            addPublisher.tintColor = UIColor.grayColor()
            addedPublisher = false
        } else {
            if !addedPublisher {
                addPublisher.setImage(added, forState: UIControlState.Normal)
                addPublisher.tintColor = UIColor.cyanColor()
                addedPublisher = true
            }
        }
    }
    
    func setParametrs(publisher: NSManagedObject) {
        self.addPublisher.setBackgroundImage(new, forState: UIControlState.Normal)
        addPublisher.tintColor = UIColor.clearColor()
        if let logoUrl = publisher.valueForKey("logo") as? String {
            
        }
    }
    
}
