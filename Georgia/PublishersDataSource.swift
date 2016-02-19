 //
//  PublishersDataSource.swift
//  Georgia
//
//  Created by MOZI Development on 11/13/15.
//  Copyright © 2015 MOZI Development. All rights reserved.
//

import Foundation
import CoreData

class PublishersDataSource: NSObject ,UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    let selectAll: UIBarButtonItem!
    
    let tableView: UITableView!
    
    var indexOfSelectedCell: NSIndexPath!
    
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
    
    init(selectAll: UIBarButtonItem, tableView: UITableView) {
        self.selectAll = selectAll
        self.tableView = tableView
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let info = self.fetchedResultsController.sections![section]
        return  info.numberOfObjects
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Publishers cell", forIndexPath: indexPath) as! PublishersCell
        let publisher = self.fetchedResultsController.objectAtIndexPath(indexPath) as! Publisher
        cell.setParameters(publisher, fetchedResultsController: self.fetchedResultsController, selectAll: self.selectAll)
        return cell
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        indexOfSelectedCell = indexPath
        return indexPath
    }
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }
    
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            if indexPath == nil {
                self.tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
            }
        case .Update:
            self.tableView.reloadRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
        case .Move:
            self.tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
            self.tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
        case .Delete:
            self.tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
        self.setSelectAll()
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }
    
    func setSelectAll() {
        if self.fetchedResultsController.fetchedObjects != nil {
            if self.selectAll.title == "Select All" {
                for publisher in self.fetchedResultsController.fetchedObjects! as! [Publisher] {
                    if publisher.isSelected == 1 {
                        self.selectAll.title = "Unselect All"
                        break
                    }
                }
                
            } else {
                var selected: Int = 0
                for publisher in self.fetchedResultsController.fetchedObjects! as! [Publisher] {
                    if publisher.isSelected == 1 {
                        selected++
                    }
                }
                if selected == 0 {
                    self.selectAll.title = "Select All"
                }
            }
        }
    }
    

}