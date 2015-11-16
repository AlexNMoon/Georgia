//
//  ArtclesView.swift
//  Georgia
//
//  Created by MOZI Development on 10/15/15.
//  Copyright (c) 2015 MOZI Development. All rights reserved.
//

import UIKit
import CoreData

class ArticlesViewController: UIViewController {
    
    let dataManager = DataManager()
    
    var articlesDataSource: ArticlesDataSource!

    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var bannerButton: UIButton!
    
    @IBOutlet var filters: UIBarButtonItem!
   
    @IBOutlet var settings: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.articlesDataSource = ArticlesDataSource(tableView: self.tableView)
        self.tableView.dataSource = self.articlesDataSource
        self.tableView.delegate = self.articlesDataSource
        self.navigationItem.rightBarButtonItems = [self.filters, self.settings]
        self.navigationItem.title = "News Feed"
        let backButton = UIBarButtonItem(image: UIImage(named: "feed_back_button"), style: .Plain, target: self, action: "closeView")
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.setHidesBackButton(false, animated: true)
       // self.dataManager.getArticles()
        self.dataManager.getBanners({(image: UIImage?) -> Void in
            if (image != nil) {
                dispatch_async(dispatch_get_main_queue(), {() -> Void in
                    self.bannerButton.setBackgroundImage(image, forState: UIControlState.Normal)
                })
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func closeView() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.barTintColor = UIColor.redColor()
        self.dataManager.getArticles()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueArticle" {
            let articleView = segue.destinationViewController as! ArticleViewController
            let article = self.articlesDataSource.fetchedResultsController.objectAtIndexPath(self.articlesDataSource.indexOfSelectedCell) as! Article
            articleView.article = article
        }
    }
    
}