//
//  ArticlesCell.swift
//  Georgia
//
//  Created by MOZI Development on 10/8/15.
//  Copyright (c) 2015 MOZI Development. All rights reserved.
//

import UIKit
import CoreData

class ArticlesCell: UITableViewCell {
    
    let dataManager = DataManager()
    
    
    
    @IBOutlet weak var publisher: UILabel!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var articleImage: UIImageView!
    
    func setParametrs(article: Article) {
        self.publisher.textColor = UIColor.cyanColor()
        if let articlesPublisher = article.valueForKey("publisher") as? Publisher {
            if let name = articlesPublisher.valueForKey("name") as? String {
                self.publisher.text = name
            }
        }
        if let articleTitle = article.valueForKey("title") as? String {
            self.title.text = articleTitle
        }
        if let image = article.valueForKey("image") as? String {
            self.articleImage.sd_setImageWithURL(NSURL(string: image))
        } else {
            self.articleImage.image = nil
        }
        
    }
    
}
