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
    
    var indexOfSelectedCell: IndexPath!
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult> {
        if self.restFetchedResultsController != nil {
            return self.restFetchedResultsController!
        }
        let entityDescription = NSEntityDescription.entity(forEntityName: "Publisher", in: self.managedObjectContext!)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
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
    
    var restFetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>?
    
    init(selectAll: UIBarButtonItem, tableView: UITableView) {
        self.selectAll = selectAll
        self.tableView = tableView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let info = self.fetchedResultsController.sections![section]
        return  info.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Publishers cell", for: indexPath) as! PublishersCell
        let publisher = self.fetchedResultsController.object(at: indexPath) as! Publisher
        cell.setParameters(publisher, fetchedResultsController: self.fetchedResultsController, selectAll: self.selectAll)
        return cell
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
            if indexPath == nil {
                self.tableView.insertRows(at: [newIndexPath!], with: UITableViewRowAnimation.automatic)
            }
        case .update:
            self.tableView.reloadRows(at: [indexPath!], with: UITableViewRowAnimation.automatic)
        case .move:
            self.tableView.deleteRows(at: [indexPath!], with: UITableViewRowAnimation.automatic)
            self.tableView.insertRows(at: [newIndexPath!], with: UITableViewRowAnimation.automatic)
        case .delete:
            self.tableView.deleteRows(at: [indexPath!], with: UITableViewRowAnimation.automatic)
        }
        self.setSelectAll()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
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
                        selected += 1
                    }
                }
                if selected == 0 {
                    self.selectAll.title = "Select All"
                }
            }
        }
    }
    

}
