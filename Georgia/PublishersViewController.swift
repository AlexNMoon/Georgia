//
//  Publishers.swift
//  
//
//  Created by MOZI Development on 10/6/15.
//
//

import UIKit
import CoreData

class PublishersViewController: UITableViewController {
    
    let dataManager = DataManager()
    
    @IBOutlet weak var selectAll: UIBarButtonItem!
    
    let added = UIImage(named: "publishers_added_icon")
    
    let add = UIImage(named: "publishers_add_icon")
    
    var publishersDataSource: PublishersDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.publishersDataSource = PublishersDataSource(selectAll: self.selectAll, tableView: self.tableView)
        self.tableView.delegate = self.publishersDataSource
        self.tableView.dataSource = self.publishersDataSource
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        let font = UIFont.systemFont(ofSize: 14);
        self.navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: font], for: UIControlState())
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: font], for: UIControlState())
        self.dataManager.getPublishers()
        self.dataManager.getCategories()
        self.publishersDataSource.setSelectAll()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.barTintColor = UIColor.red
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seguePublisher" {
            let publisherView = segue.destination as! PublisherViewController
            let publisher = self.publishersDataSource.fetchedResultsController.object(at: publishersDataSource.indexOfSelectedCell) as! Publisher
            publisherView.publisher = publisher
        }
    }
    
    @IBAction func tapSelectAll(_ sender: AnyObject) {
        if selectAll.title == "Select All" {
            self.selectAllPublishers()
        } else {
            for publisher in self.publishersDataSource.fetchedResultsController.fetchedObjects! as! [Publisher] {
                if publisher.isSelected == 1 {
                    publisher.isSelected = 0
                }
            }
            do {
                try self.publishersDataSource.managedObjectContext?.save()
            } catch _ {
            }
        }
    }
    
    func selectAllPublishers() {
        for  publisher in self.publishersDataSource.fetchedResultsController.fetchedObjects! as! [Publisher] {
            if publisher.isSelected != 1 {
                publisher.isSelected = 1
            }
        }
        do {
            try self.publishersDataSource.managedObjectContext?.save()
        } catch _ {
        }
        self.dataManager.getArticles()
    }
    
    @IBAction func tapViewSelected(_ sender: AnyObject) {
        if self.selectAll.title == "Select All" {
            let alertController = UIAlertController(title: "You have not selected any publisher", message: nil, preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Return to selection", style: UIAlertActionStyle.default,handler: nil))
            alertController.addAction(UIAlertAction(title: "Select all", style: UIAlertActionStyle.default ,handler: { alertAction in
                self.selectAllPublishers()
                self.navigationController?.pushViewController(self.storyboard?.instantiateViewController(withIdentifier: "Articles View Controller") as! ArticlesViewController, animated: true)
            }))
            self.present(alertController, animated: true, completion: nil)
        } else {
            self.dataManager.getArticles()
            self.navigationController?.pushViewController(self.storyboard?.instantiateViewController(withIdentifier: "Articles View Controller") as! ArticlesViewController, animated: true)
        }
    }
}
