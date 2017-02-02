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
    
    var indexOfSelectedCell: IndexPath!
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    
    var refreshControl:UIRefreshControl!
    
    let dataManager = DataManager()
    
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult> {
        if self.restFetchedResultsController != nil {
            return self.restFetchedResultsController!
        }
        let entityDescription = NSEntityDescription.entity(forEntityName: "Article", in: self.managedObjectContext!)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
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
    
    var restFetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>?
    
    var tableView: UITableView!
    
    init(tableView: UITableView) {
        super.init()
        self.tableView = tableView
        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: #selector(ArticlesDataSource.refresh(_:)), for: UIControlEvents.valueChanged)
        self.tableView.addSubview(refreshControl)
    }
    
    func refresh(_ sender:AnyObject) {
        self.dataManager.getArticles()
        self.refreshControl?.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let info = self.fetchedResultsController.sections![section]
        return info.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Articles Cell", for: indexPath) as! ArticlesCell
        let article = self.fetchedResultsController.object(at: indexPath) as! Article
        cell.setParameters(article)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 109.0
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        indexOfSelectedCell = indexPath
        return indexPath
    }
    
    
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            self.tableView.insertRows(at: [newIndexPath!], with: UITableViewRowAnimation.automatic)
        case .update:
            self.tableView.reloadRows(at: [indexPath!], with: UITableViewRowAnimation.automatic)
        case .move:
            self.tableView.deleteRows(at: [indexPath!], with: UITableViewRowAnimation.automatic)
            self.tableView.insertRows(at: [newIndexPath!], with: UITableViewRowAnimation.automatic)
        case .delete:
            self.tableView.deleteRows(at: [indexPath!], with: UITableViewRowAnimation.automatic)
        }
        
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
    }


}
