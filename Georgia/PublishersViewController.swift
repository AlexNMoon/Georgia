//
//  Publishers.swift
//  
//
//  Created by MOZI Development on 10/6/15.
//
//

import UIKit
import CoreData

class PublishersViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var cellQuantity: Int = 0
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var fetchedResultsController: NSFetchedResultsController {
        if self.restFetchedResultsController != nil {
            return self.restFetchedResultsController!
        }
        let entityDescription = NSEntityDescription.entityForName("Publisher", inManagedObjectContext: self.managedObjectContext!)
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity = entityDescription
        let sort = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        aFetchedResultsController.delegate = self
        self.restFetchedResultsController = aFetchedResultsController
        var e: NSError?
        do {
            try self.restFetchedResultsController!.performFetch()
        } catch let error as NSError {
            e = error
            print("fetch error: \(e!.localizedDescription)")
            abort();
        }
        
        return self.restFetchedResultsController!
    }
    var restFetchedResultsController: NSFetchedResultsController?
    
    let dataManager = DataManager()
    
    var indexOfSelectedCell: NSIndexPath!
    
    @IBOutlet weak var selectAll: UIBarButtonItem!
    
    let added = UIImage(named: "publishers_added_icon")
    
    let add = UIImage(named: "publishers_add_icon")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        self.dataManager.getPublishers(nil, completionHandler: {(publisherForArticle) -> Void in
        })
        self.tableView!.reloadData()
        self.setSelectAll()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let info = self.fetchedResultsController.sections![section] 
        self.cellQuantity = info.numberOfObjects
        return self.cellQuantity
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Publishers cell", forIndexPath: indexPath) as! PublishersCell
        let publisher = self.fetchedResultsController.objectAtIndexPath(indexPath) as! Publisher
        cell.setParametrs(publisher, fetchedResultsController: self.fetchedResultsController)
        cell.selectAll = self.selectAll
        return cell
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.barTintColor = UIColor.redColor()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "seguePublisher" {
            let publisherView = segue.destinationViewController as! PublisherViewController
            let publisher = self.fetchedResultsController.objectAtIndexPath(indexOfSelectedCell) as! Publisher
            publisherView.publisher = publisher
        }
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        indexOfSelectedCell = indexPath
        return indexPath
    }
    
    @IBAction func tapSelectAll(sender: AnyObject) {
        if selectAll.title == "Select All" {
            for index in 0 ..< self.cellQuantity {
                let publisher = self.fetchedResultsController.objectAtIndexPath(NSIndexPath(forRow: index, inSection: 0)) as! Publisher
                if publisher.isSelected != 1 {
                    publisher.isSelected = 1
                }
            }
            self.selectAll.title = "Unselect All"
        } else {
            for index in 0 ..< self.cellQuantity {
                let publisher = self.fetchedResultsController.objectAtIndexPath(NSIndexPath(forRow: index, inSection: 0)) as! Publisher
                if publisher.isSelected == 1 {
                    publisher.isSelected = 0
                }
            }
            self.selectAll.title = "Select All"
        }
        self.tableView.reloadData()
        do {
            try self.managedObjectContext?.save()
        } catch _ {
        }
    }
    
    
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }
    
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            print("insert")
            self.tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
        case .Update:
            let cell = self.tableView.cellForRowAtIndexPath(indexPath!) as! PublishersCell
            let publisher = self.fetchedResultsController.objectAtIndexPath(indexPath!) as! Publisher
            print("update")
            cell.setParametrs(publisher, fetchedResultsController: self.fetchedResultsController)
            self.tableView.reloadRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
        case .Move:
            print("move")
            self.tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
            self.tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
        case .Delete:
            print("delete")
            self.tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
        self.setSelectAll()
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }
    
    func setSelectAll() {
        if self.cellQuantity > 0 {
            for index in 1 ..< self.cellQuantity {
                let publisher = self.fetchedResultsController.objectAtIndexPath(NSIndexPath(forRow: index, inSection: 0)) as! Publisher
                if publisher.isSelected == 1 {
                    self.selectAll.title = "Unselect All"
                    break
                }
            }
        }
    }
}