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

    @IBOutlet var filters: UIBarButtonItem!
   
    @IBOutlet var settings: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.articlesDataSource = ArticlesDataSource(tableView: self.tableView)
        self.tableView.dataSource = self.articlesDataSource
        self.tableView.delegate = self.articlesDataSource
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        let font = UIFont.systemFont(ofSize: 22);
        self.settings.setTitleTextAttributes([NSFontAttributeName: font], for: UIControlState())
        self.navigationItem.rightBarButtonItems = [self.settings, self.filters]
        self.navigationItem.title = "News Feed"
        let backButton = UIBarButtonItem(image: UIImage(named: "feed_back_button"), style: .plain, target: self, action: #selector(ArticlesViewController.closeView))
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.setHidesBackButton(false, animated: true)
        self.dataManager.getArticles()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func closeView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.barTintColor = UIColor.red
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueArticle" {
            let articleView = segue.destination as! ArticleViewController
            let article = self.articlesDataSource.fetchedResultsController.object(at: self.articlesDataSource.indexOfSelectedCell) as! Article
            articleView.article = article
        }
    }
    
}
