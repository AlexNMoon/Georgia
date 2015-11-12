//
//  FiltersCell.swift
//  Georgia
//
//  Created by MOZI Development on 10/20/15.
//  Copyright (c) 2015 MOZI Development. All rights reserved.
//

import UIKit

class FiltersCell: UITableViewCell {
    
    @IBOutlet weak var addCategory: UIButton!
    
    @IBOutlet weak var categoryName: UILabel!
    
    let add = UIImage(named: "publishers_add_icon")
    
    let added = UIImage(named: "publishers_added_icon")
    
    var addedCategory: Bool = false
    
    @IBAction func tapAddCategory(sender: AnyObject) {
        if addedCategory {
            addCategory.setImage(add, forState: UIControlState.Normal)
            addCategory.tintColor = UIColor.grayColor()
            addedCategory = false
        } else {
            addCategory.setImage(added, forState: UIControlState.Normal)
            addCategory.tintColor = UIColor.cyanColor()
            addedCategory = true
        }
    }
}
