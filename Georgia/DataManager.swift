//
//  DataManager.swift
//  Georgia
//
//  Created by MOZI Development on 10/2/15.
//  Copyright (c) 2015 MOZI Development. All rights reserved.
//

import Foundation
import CoreData
import SwiftyJSON

class DataManager {
    
        
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    let api = API()
    
    
    
    func getText(id: Int, completionHandler: (data: JSON?) -> Void) {
        api.searchFor(.Text, articleId: id, completionHandler: { (json: JSON) -> Void in
            completionHandler(data: json["data"])
        })
    }
    
    func getArticles() {
        let articlesManagedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
        articlesManagedObjectContext.parentContext = self.managedObjectContext
        let entityDescription =
        NSEntityDescription.entityForName("Article",
            inManagedObjectContext: articlesManagedObjectContext)
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity = entityDescription
        let results = try? articlesManagedObjectContext.executeFetchRequest(fetchRequest)
        let articles = results as! [NSManagedObject]
        for index in 0 ..< articles.count {
            articlesManagedObjectContext.deleteObject(articles[index])
        }
        do {
            try articlesManagedObjectContext.save()
        } catch _ {
        }
        api.searchFor(.Articles, articleId: nil, completionHandler: { (json: JSON) -> Void in
            if let data = json["data"].array {
                for index in 0 ..< data.count {
                    let articleData = data[index]
                        let restArticle = RestArticle(articleData: articleData)
                        _ = Article(article: restArticle, entity: entityDescription!, insertIntoManagedObjectContext: articlesManagedObjectContext)
                }
            }
            do {
                try articlesManagedObjectContext.save()
            } catch _ {
            }
        })
    }
    
    func getPublishers(publisherIndex: Int?, completionHandler: (publisherForArticle: Publisher) -> Void) {
        let publishersManagedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
        publishersManagedObjectContext.parentContext = self.managedObjectContext
        let entityDescription = NSEntityDescription.entityForName("Publisher", inManagedObjectContext: publishersManagedObjectContext)
        var publishers = [Publisher]()
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity = entityDescription
        let results = try? publishersManagedObjectContext.executeFetchRequest(fetchRequest)
        publishers = results as! [Publisher]
        if let publIndex = publisherIndex {
            for publisher in publishers {
                if publisher.publidherId == publIndex {
                    completionHandler(publisherForArticle: publisher)
                    break
                }
            }
        } else {
            api.searchFor(.Publishers, articleId: nil, completionHandler: { (json: JSON) -> Void in
                if let data = json["data"].array {
                    if publishers.count == 0 {
                        for index in 0 ..< data.count {
                            let publisherData = data[index]
                            let restPublisher = RestPublisher(publisherData: publisherData)
                            _ = Publisher(publisher: restPublisher, entity: entityDescription!, insertIntoManagedObjectContext: publishersManagedObjectContext)
                        }
                    } else {
                        var number: Int = 0
                        for index in 0 ..< data.count {
                            for publisher in publishers {
                                if publisher.publidherId == data[index]["id"].int {
                                    number++
                                }
                            }
                            if number == 0 {
                                let restPublisher = RestPublisher(publisherData: data[index])
                                _ = Publisher(publisher: restPublisher, entity: entityDescription!, insertIntoManagedObjectContext: publishersManagedObjectContext)
                            }
                        }
                    }
                    
                }
                do {
                    try publishersManagedObjectContext.save()
                } catch _ {
                }
            })
        }
    }

    func getBanners(completitionHandler: (image: UIImage?) ->  Void) {
        let bannersManagedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
        bannersManagedObjectContext.parentContext = self.managedObjectContext
        let entityDescription =
        NSEntityDescription.entityForName("Banner",
            inManagedObjectContext: bannersManagedObjectContext)
        api.searchFor(.Banners, articleId: nil, completionHandler: { (json: JSON) -> Void in
            if let data = json["data"].array {
                if data.count == 0 {
                    completitionHandler(image: UIImage(named: "launch_background.png")!)
                } else {
                    for index in 0 ..< data.count {
                        let bannerData = data[index]
                        let restBanner = RestBanner(bannerData: bannerData)
                        _ = Banner(banner: restBanner, entity: entityDescription!, insertIntoManagedObjectContext: bannersManagedObjectContext)
                    }
                }
            }
            do {
                try bannersManagedObjectContext.save()
            } catch _ {
            }
            
        })
    }
    
    func getCategories(categoryIndex: Int?, completionHandler: (categoryForArticle: Category) -> Void) {
        let categoriesManagedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
        categoriesManagedObjectContext.parentContext = self.managedObjectContext
        let entityDescription =
        NSEntityDescription.entityForName("Category",
            inManagedObjectContext: categoriesManagedObjectContext)
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity = entityDescription
        let results = try? categoriesManagedObjectContext.executeFetchRequest(fetchRequest)
        let categories = results as! [Category]
        if let categIndex = categoryIndex {
            for category in categories {
                if category.categoriesId == categIndex {
                    completionHandler(categoryForArticle: category)
                    break
                }
            }
        } else {
            api.searchFor(.Categories, articleId: nil, completionHandler: { (json: JSON) -> Void in
                if let data = json["data"].array {
                    if categories.count == 0 {
                        for index in 0 ..< data.count {
                            let categoryData = data[index]
                            let restCategory = RestCategory(categoryData: categoryData)
                            _ = Category(category: restCategory, entity: entityDescription!, insertIntoManagedObjectContext: categoriesManagedObjectContext)
                        }
                    } else {
                        
                    }
                }
                do {
                    try categoriesManagedObjectContext.save()
                } catch _ {
                }
            })
        }
    }
    
}
