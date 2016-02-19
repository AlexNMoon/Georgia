//
//  FiltersDataSource.swift
//  Georgia
//
//  Created by MOZI Development on 11/13/15.
//  Copyright © 2015 MOZI Development. All rights reserved.
//

import Foundation
import CoreData

class FiltersDataSource: NSObject ,UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    let selectAll: UIBarButtonItem!
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    let tableView: UITableView!
    
    var fetchedResultsController: NSFetchedResultsController {
        if self.restFetchedResultsController != nil {
            return self.restFetchedResultsController!
        }
        let entityDescription = NSEntityDescription.entityForName("Category", inManagedObjectContext: self.managedObjectContext!)
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity = entityDescription
        let sort = NSSortDescriptor(key: "title", ascending: true)
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
    
    init(tableView: UITableView, selectAll: UIBarButtonItem) {
        self.tableView = tableView
        self.selectAll = selectAll
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let info = self.fetchedResultsController.sections![section]
        return  info.numberOfObjects
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Filters Cell", forIndexPath: indexPath) as! FiltersCell
        let category = self.fetchedResultsController.objectAtIndexPath(indexPath) as! Category
        cell.setParameters(category, fetchedResultsController: self.fetchedResultsController, selectAll: self.selectAll)
        return cell
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
            if self.selectAll.title == "Unselect All" {
                for category in self.fetchedResultsController.fetchedObjects! as! [Category] {
                    if category.isSelected != 1 {
                        self.selectAll.title = "Select All"
                        break
                    }
                }
            } else {
                var unselected: Int = 0
                for category in self.fetchedResultsController.fetchedObjects! as! [Category] {
                    if category.isSelected != 1 {
                        unselected++
                    }
                }
                if unselected == 0 {
                    self.selectAll.title = "Unselect All"
                }
            }
        }
    }

}