//
//  Publishers.swift
//  
//
//  Created by MOZI Development on 10/6/15.
//
//

import UIKit
import CoreData

class PublishersView: UITableViewController, NSFetchedResultsControllerDelegate {
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var fetchedResultsController: NSFetchedResultsController {
        if self.restFetchedResultsController != nil {
            return self.restFetchedResultsController!
        }
        let managedObjectContext = self.managedObjectContext!
        let entityDescription = NSEntityDescription.entityForName("Publisher", inManagedObjectContext: managedObjectContext)
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity = entityDescription
        let sort = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        aFetchedResultsController.delegate = self
        self.restFetchedResultsController = aFetchedResultsController
        var e: NSError?
        if !self.restFetchedResultsController!.performFetch(&e) {
            println("fetch error: \(e!.localizedDescription)")
            abort();
        }
        
        return self.restFetchedResultsController!
    }
    var restFetchedResultsController: NSFetchedResultsController?
    
    let dataManager = DataManager()
    
   // var publishers = [Publisher]()
    
    var indexOfSelectedCell: NSIndexPath!
    
    @IBOutlet weak var selectAll: UIBarButtonItem!
    
    let added = UIImage(named: "publishers_added_icon@3x.png")
    
    let add = UIImage(named: "publishers_add_icon@3x.png")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        self.dataManager.getPublishers(nil, completionHandler: {(publisherForArticle) -> Void in})
      /*  let entityDescription = NSEntityDescription.entityForName("Publisher", inManagedObjectContext: managedObjectContext!)
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity = entityDescription
        let results = managedObjectContext?.executeFetchRequest(fetchRequest, error: nil)
        self.publishers = results as! [Publisher]
        for publisher in publishers {
            if publisher.isSelected as? Int == 1 {
                self.selectAll.title = "Unselect All"
                break
            }
        }*/
        self.tableView!.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let info = self.fetchedResultsController.sections![section] as! NSFetchedResultsSectionInfo
        return info.numberOfObjects
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Publishers cell", forIndexPath: indexPath) as! PublishersCell
        let publisher = self.fetchedResultsController.objectAtIndexPath(indexPath) as! Publisher
        cell.setParametrs(publisher)
        cell.selectAll = self.selectAll
        return cell
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.barTintColor = UIColor.redColor()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "seguePublisher" {
            let publisherView = segue.destinationViewController as! PublisherView
            let publisher = self.fetchedResultsController.objectAtIndexPath(indexOfSelectedCell) as! Publisher
            publisherView.publisher = publisher
        }
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        indexOfSelectedCell = indexPath
        return indexPath
    }
    
  /*  @IBAction func tapSelectAll(sender: AnyObject) {
        if selectAll.title == "Select All" {
            for publisher in publishers {
                if publisher.isSelected != 1 {
                    publisher.isSelected = 1
                }
            }
            self.selectAll.title = "Unselect All"
        } else {
            if selectAll.title == "Unselect All" {
                for publisher in publishers {
                    if publisher.isSelected == 1 {
                        publisher.isSelected = 0
                    }
                }
                self.selectAll.title = "Select All"
            }
        }
        self.tableView.reloadData()
        self.managedObjectContext?.save(nil)
    }
    
    */
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }
    
    /* called:
    - when a new model is created
    - when an existing model is updated
    - when an existing model is deleted */
    func controller(controller: NSFetchedResultsController,
        didChangeObject object: AnyObject,
        atIndexPath indexPath: NSIndexPath?,
        forChangeType type: NSFetchedResultsChangeType,
        newIndexPath: NSIndexPath?) {
            switch type {
            case .Insert:
                println("insert")
                self.tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
            case .Update:
                let cell = self.tableView.cellForRowAtIndexPath(indexPath!) as! PublishersCell
                let publisher = self.fetchedResultsController.objectAtIndexPath(indexPath!) as! Publisher
                println("update")
                cell.setParametrs(publisher)
                self.tableView.reloadRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
            case .Move:
                println("move")
                self.tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
                self.tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
            case .Delete:
                println("delete")
                self.tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
            default:
                return
            }
    }
    
    /* called last
    tells `UITableView` updates are complete */
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }
    
}