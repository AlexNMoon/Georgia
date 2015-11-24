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
        let font = UIFont.systemFontOfSize(14);
        self.navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: font], forState: UIControlState.Normal)
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: font], forState: UIControlState.Normal)
        self.dataManager.getPublishers(nil, completionHandler: {(publisherForArticle) -> Void in
        })
        self.dataManager.getCategories(nil, completionHandler: {(categoryForArticle: Category) -> Void in})
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
            self.selectAllPublishers()
        } else {
            for publisher in self.publishersDataSource.fetchedResultsController.fetchedObjects! as! [Publisher] {
                if publisher.isSelected == 1 {
                    publisher.isSelected = 0
                }
            }
            do {
                try self.publishersDataSource.managedObjectContext?.save()
            } catch _ {
            }
        }
    }
    
    func selectAllPublishers() {
        for  publisher in self.publishersDataSource.fetchedResultsController.fetchedObjects! as! [Publisher] {
            if publisher.isSelected != 1 {
                publisher.isSelected = 1
            }
        }
        do {
            try self.publishersDataSource.managedObjectContext?.save()
        } catch _ {
        }
    }
    
    @IBAction func tapViewSelected(sender: AnyObject) {
        if self.selectAll.title == "Select All" {
            let alertController = UIAlertController(title: "You have not selected any publisher", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Return to selection", style: UIAlertActionStyle.Default,handler: nil))
            alertController.addAction(UIAlertAction(title: "Select all", style: UIAlertActionStyle.Default ,handler: { alertAction in
                self.selectAllPublishers()
                self.navigationController?.pushViewController(self.storyboard?.instantiateViewControllerWithIdentifier("Articles View Controller") as! ArticlesViewController, animated: true)
            }))
            self.presentViewController(alertController, animated: true, completion: nil)
        } else {
            self.navigationController?.pushViewController(self.storyboard?.instantiateViewControllerWithIdentifier("Articles View Controller") as! ArticlesViewController, animated: true)
        }
    }
}