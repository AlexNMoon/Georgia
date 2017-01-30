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
    
    let dataManager = DataManager()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.filtersDataSource = FiltersDataSource(tableView: self.tableView, selectAll: self.selectAllButton)
        self.tableView.delegate = self.filtersDataSource
        self.tableView.dataSource = self.filtersDataSource
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        self.navigationItem.title = "Filters"
        let backButton = UIBarButtonItem(image: UIImage(named: "filters_close_button"), style: .plain, target: self, action: #selector(FiltersViewController.closeView))
        self.navigationItem.rightBarButtonItem = backButton
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.leftBarButtonItem = selectAllButton
        let font = UIFont.systemFont(ofSize: 14);
        self.navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: font], for: UIControlState())
        self.filtersDataSource.setSelectAll()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.barTintColor = UIColor.darkGray
    }
    
    func closeView() {
        self.navigationController?.dismiss(animated: true, completion: {() -> Void in })
    }
    
    @IBAction func tapSelectAll(_ sender: AnyObject) {
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
        self.dataManager.getArticles()
        self.dataManager.sendAPNSSettings()
    }
    
}
