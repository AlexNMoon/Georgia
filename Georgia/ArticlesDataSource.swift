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
    
    var refreshControl:UIRefreshControl!
    
    let dataManager = DataManager()
    
    var fetchedResultsController: NSFetchedResultsController {
        if self.restFetchedResultsController != nil {
            return self.restFetchedResultsController!
        }
        let entityDescription = NSEntityDescription.entityForName("Article", inManagedObjectContext: self.managedObjectContext!)
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity = entityDescription
        let sort = NSSortDescriptor(key: "publisherTime", ascending: false)
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
    
    var tableView: UITableView!
    
    init(tableView: UITableView) {
        super.init()
        self.tableView = tableView
        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
    }
    
    func refresh(sender:AnyObject) {
        self.dataManager.updatingArticles()
        self.refreshControl?.endRefreshing()
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
            self.tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
        case .Update:
            self.tableView.reloadRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
        case .Move:
            self.tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
            self.tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
        case .Delete:
            self.tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
        
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }


}