//
//  FiltersView.swift
//  Georgia
//
//  Created by MOZI Development on 10/12/15.
//  Copyright (c) 2015 MOZI Development. All rights reserved.
//

import UIKit
import CoreData

class FiltersViewController: UITableViewController {

    @IBOutlet var selectAllButton: UIBarButtonItem!
    
    var filtersDataSource: FiltersDataSource!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.filtersDataSource = FiltersDataSource(tableView: self.tableView, selectAll: self.selectAllButton)
        self.tableView.delegate = self.filtersDataSource
        self.tableView.dataSource = self.filtersDataSource
        self.navigationItem.title = "Filters"
        let backButton = UIBarButtonItem(image: UIImage(named: "feed_back_button"), style: .Plain, target: self, action: "closeView")
        self.navigationItem.rightBarButtonItem = backButton
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.leftBarButtonItem = selectAllButton
        let font = UIFont.systemFontOfSize(14);
        self.navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: font], forState: UIControlState.Normal)
        self.filtersDataSource.setSelectAll()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.barTintColor = UIColor.darkGrayColor()
    }
    
    func closeView() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
        
    @IBAction func tapSelectAll(sender: AnyObject) {
        if selectAllButton.title == "Select All" {
            for  category in self.filtersDataSource.fetchedResultsController.fetchedObjects! as! [Category] {
                if category.isSelected != 1 {
                    category.isSelected = 1
                }
            }
        selectAllButton.title = "Unselect All"
        } else {
            for category in self.filtersDataSource.fetchedResultsController.fetchedObjects! as! [Category] {
                if category.isSelected == 1 {
                    category.isSelected = 0
                }
            }
            selectAllButton.title = "Select All"
        }
        do {
            try self.filtersDataSource.managedObjectContext?.save()
        } catch _ {
        }

    }
    
  }
