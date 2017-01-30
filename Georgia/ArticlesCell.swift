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
    
    @IBOutlet weak var time: UILabel!
    
    let defoultImage = UIImage(named: "launch_logo")
   
    func setParameters(_ article: Article) {
        self.publisher.textColor = UIColor.cyan
        self.time.textColor = UIColor.lightGray
        if let publisherName = article.publisher.name {
                self.publisher.text = publisherName
        }
        if let articleTitle = article.title {
            self.title.text = articleTitle
            
        }
        if let image = article.publisher.logo {
            self.articleImage.sd_setImage(with: URL(string: image))
            if self.articleImage.image == nil {
                self.articleImage.image = self.defoultImage
            }
        }
        if let time = article.publisherTime {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = DateFormatter.Style.full
            dateFormatter.dateFormat = "HH:mm | yyyy/MM/dd"
            let date = Date(timeIntervalSince1970: time.doubleValue)
            self.time.text = dateFormatter.string(from: date)
        }
    }
    
}
