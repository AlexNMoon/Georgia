//
//  PublishersCell.swift
//  Georgia
//
//  Created by MOZI Development on 9/30/15.
//  Copyright (c) 2015 MOZI Development. All rights reserved.
//

import UIKit

class PublishersCell: UITableViewCell {

    @IBOutlet weak var addPublisher: UIButton!
    
    @IBOutlet weak var logo: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    var addedPublisher: Bool = false
    
    let add = UIImage(named: "publishers_add_icon@3x.png")
    
    let added = UIImage(named: "publishers_added_icon@3x.png")

    
    @IBAction func tapAddPublisherButton(sender: AnyObject) {
        if addedPublisher {
            addPublisher.setBackgroundImage(add, forState: UIControlState.Normal)
            addedPublisher = false
        } else {
            if !addedPublisher {
                addPublisher.setBackgroundImage(added, forState: UIControlState.Normal)
                addedPublisher = true
            }
        }
    }
    
    func setParametrs(publisher: Publishers) {
        self.addPublisher.setBackgroundImage(add, forState: UIControlState.Normal)
        self.name.text = "Mmmmmmm"
        self.logo.image = add
        //self.logo.sd_setImageWithURL(NSURL(string: publisher.logo as String))
    }
    
}
