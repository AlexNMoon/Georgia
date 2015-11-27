//
//  FiltersCell.swift
//  Georgia
//
//  Created by MOZI Development on 10/20/15.
//  Copyright (c) 2015 MOZI Development. All rights reserved.
//

import UIKit
import CoreData

class FiltersCell: UITableViewCell {
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var fetchedResultsController: NSFetchedResultsController!
    
    @IBOutlet weak var addCategory: UIButton!
    
    @IBOutlet weak var categoryName: UILabel!
    
    let add = UIImage(named: "publishers_add_icon")
    
    let added = UIImage(named: "publishers_added_icon")
    
    var category: Category!
    
    var selectAll: UIBarButtonItem!
    
    let dataManager = DataManager()
    
    func setParameters(category: Category, fetchedResultsController: NSFetchedResultsController, selectAll: UIBarButtonItem) {
        self.category = category
        self.fetchedResultsController = fetchedResultsController
        self.selectAll = selectAll
        if let name = category.title {
            self.categoryName.text = name
        }
        if category.isSelected == 1 {
            self.categoryIsSelected()
        } else {
            self.categoryIsUnselected()
        }

    }
    
    @IBAction func tapAddCategory(sender: AnyObject) {
        if category.isSelected == 1 {
            self.categoryUnselectedCoreData()
        } else {
            self.categorySelectedCoreData()
        }
        self.dataManager.getArticles()
    }
    
    func categoryIsSelected() {
        addCategory.setImage(added, forState: UIControlState.Normal)
        addCategory.tintColor = UIColor.grayColor()
    }
    
    func categoryIsUnselected() {
        addCategory.setImage(add, forState: UIControlState.Normal)
        addCategory.tintColor = UIColor.cyanColor()
    }
    
    func categorySelectedCoreData() {
        category.isSelected = 1
        do {
            try managedObjectContext?.save()
        } catch _ {
        }
    }
    
    func categoryUnselectedCoreData() {
        category.isSelected = 0
        do {
            try managedObjectContext?.save()
        } catch _ {
        }
    }

}
