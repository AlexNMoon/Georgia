//
//  Publishers.swift
//  
//
//  Created by MOZI Development on 10/6/15.
//
//

import UIKit
import CoreData

class PublishersViewController: UITableViewController {
    
    let dataManager = DataManager()
    
    @IBOutlet weak var selectAll: UIBarButtonItem!
    
    let added = UIImage(named: "publishers_added_icon")
    
    let add = UIImage(named: "publishers_add_icon")
    
    var publishersDataSource: PublishersDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.publishersDataSource = PublishersDataSource(selectAll: self.selectAll, tableView: self.tableView)
        self.tableView.delegate = self.publishersDataSource
        self.tableView.dataSource = self.publishersDataSource
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        self.dataManager.getPublishers(nil, completionHandler: {(publisherForArticle) -> Void in
        })
        
        self.publishersDataSource.setSelectAll()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.barTintColor = UIColor.redColor()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "seguePublisher" {
            let publisherView = segue.destinationViewController as! PublisherViewController
            let publisher = self.publishersDataSource.fetchedResultsController.objectAtIndexPath(publishersDataSource.indexOfSelectedCell) as! Publisher
            publisherView.publisher = publisher
        }
    }
    
    @IBAction func tapSelectAll(sender: AnyObject) {
        if selectAll.title == "Select All" {
            for  publisher in self.publishersDataSource.fetchedResultsController.fetchedObjects! as! [Publisher] {
                if publisher.isSelected != 1 {
                    publisher.isSelected = 1
                }
            }
            self.selectAll.title = "Unselect All"
        } else {
            for publisher in self.publishersDataSource.fetchedResultsController.fetchedObjects! as! [Publisher] {
                if publisher.isSelected == 1 {
                    publisher.isSelected = 0
                }
            }
            self.selectAll.title = "Select All"
        }
        do {
            try self.publishersDataSource.managedObjectContext?.save()
        } catch _ {
        }
    }
    
    @IBAction func tapViewSelected(sender: AnyObject) {
        if self.selectAll.title == "Select All" {
            
        }
    }
}