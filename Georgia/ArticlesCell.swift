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
    
    func setParameters(article: Article) {
        self.publisher.textColor = UIColor.cyanColor()
        if let publisherName = article.publisher.name {
                self.publisher.text = publisherName
        }
        if let articleTitle = article.title {
            self.title.text = articleTitle
        }
        if let image = article.publisher.logo {
            self.articleImage.sd_setImageWithURL(NSURL(string: image))
        }
    }
    
}
