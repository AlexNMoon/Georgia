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
    
    let add = UIImage(named: "publishers_add_icon@3x.png")
    
    let added = UIImage(named: "publishers_added_icon@3x.png")
    
    var addedCategory: Bool = false
    
    @IBAction func tapAddCategory(sender: AnyObject) {
        if addedCategory {
            addCategory.setImage(add, forState: UIControlState.Normal)
            addCategory.tintColor = UIColor.grayColor()
            addedCategory = false
        } else {
            if !addedCategory {
                addCategory.setImage(added, forState: UIControlState.Normal)
                addCategory.tintColor = UIColor.cyanColor()
                addedCategory = true
            }
        }
    }

}
