//
//  ArticlesDataSource.swift
//  Georgia
//
//  Created by MOZI Development on 11/13/15.
//  Copyright © 2015 MOZI Development. All rights reserved.
//

import Foundation
import CoreData

class ArticlesDataSource: NSObject ,UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate  {
    
    var indexOfSelectedCell: NSIndexPath!
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var fetchedResultsController: NSFetchedResultsController {
        if self.restFetchedResultsController != nil {
            return self.restFetchedResultsController!
        }
        let entityDescription = NSEntityDescription.entityForName("Article", inManagedObjectContext: self.managedObjectContext!)
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
    
    let tableView: UITableView!
    
    init(tableView: UITableView) {
        self.tableView = tableView
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let info = self.fetchedResultsController.sections![section]
        return info.numberOfObjects
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Articles Cell", forIndexPath: indexPath) as! ArticlesCell
        let article = self.fetchedResultsController.objectAtIndexPath(indexPath) as! Article
        cell.setParameters(article)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 109.0
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
            print("insert")
            self.tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
        case .Update:
            print("update")
            self.tableView.reloadRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
        case .Move:
            print("move")
            self.tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
            self.tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
        case .Delete:
            print("delete")
            self.tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
        
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }


}