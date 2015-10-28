//
//  FiltersView.swift
//  Georgia
//
//  Created by MOZI Development on 10/12/15.
//  Copyright (c) 2015 MOZI Development. All rights reserved.
//

import UIKit

class FiltersView: UITableViewController {

    @IBOutlet var selectAllButton: UIBarButtonItem!
    
    let dataManager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Filters"
        var backButton = UIBarButtonItem(image: UIImage(named: "filters_close_button@3x.png"), style: .Plain, target: self, action: "closeView")
        self.navigationItem.rightBarButtonItem = backButton
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.leftBarButtonItem = selectAllButton
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.barTintColor = UIColor.darkGrayColor()
    }
    
    func closeView() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Filters Cell", forIndexPath: indexPath) as! FiltersCell
        self.dataManager.getCategories(indexPath.item, completitionHandler: { (name: String) -> Void in
            dispatch_async(dispatch_get_main_queue(), {() -> Void in
                cell.categoryName.text = name
            })
        })
        return cell
    }
    
    @IBAction func tapSelectAll(sender: AnyObject) {
    }
    
  }
