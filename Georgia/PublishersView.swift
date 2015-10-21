//
//  Publishers.swift
//  
//
//  Created by MOZI Development on 10/6/15.
//
//

import UIKit
import CoreData

class PublishersView: UITableViewController {
    
    let dataManager = DataManager()
    
    var publishers = [NSManagedObject]()
    
    var indexOfSelectedCell = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        self.dataManager.getPublishers({(publishers: [NSManagedObject]) -> Void in
            self.publishers = publishers
            dispatch_async(dispatch_get_main_queue(), {() -> Void in
                self.tableView!.reloadData()
            })
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return publishers.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Publishers cell", forIndexPath: indexPath) as! PublishersCell
        if publishers.count > 0 {
            cell.setParametrs(publishers[indexPath.item])
        }
        return cell
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.barTintColor = UIColor.redColor()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "seguePublisher" {
            let publisherView = segue.destinationViewController as! PublisherView
            publisherView.publisher = publishers[indexOfSelectedCell]
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        indexOfSelectedCell = indexPath.item
    }
    
}