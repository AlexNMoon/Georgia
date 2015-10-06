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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Publishers cell", forIndexPath: indexPath) as! PublishersCell
        cell.setParametrs()
        return cell
    }
    
}