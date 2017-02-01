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
    
    var managedObjectContext: NSManagedObjectContext?
    
    var deviceToken: String? = nil
    
    let api = API()
    
    init() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            self.managedObjectContext = appDelegate.managedObjectContext!
        }
        else {
            self.managedObjectContext = nil
        }
    }
    
    func getText(_ id: Int, completionHandler: @escaping (_ data: JSON?) -> Void) {
        api.searchFor(.text, articleId: id, completionHandler: { (json: JSON) -> Void in
            completionHandler(json["data"])
        })
    }
    
    func getArticles() {
        let articlesManagedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.privateQueueConcurrencyType)
        articlesManagedObjectContext.parent = self.managedObjectContext
        let entityDescription = NSEntityDescription.entity(forEntityName: "Article", in: articlesManagedObjectContext)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        fetchRequest.entity = entityDescription
        let results = try? articlesManagedObjectContext.fetch(fetchRequest)
        let articles = results as! [Article]
        for index in 0 ..< articles.count {
            articlesManagedObjectContext.delete(articles[index])
        }
        do {
            try articlesManagedObjectContext.save()
        } catch _ {
        }
        api.searchFor(.articles, articleId: nil, completionHandler: { (json: JSON) -> Void in
            if let data = json["data"].array {
                for index in 0 ..< data.count {
                    self.createArticle(data[index], entityDescription: entityDescription!, articlesManagedObjectContext: articlesManagedObjectContext)
                }
            }
            do {
                try articlesManagedObjectContext.save()
            } catch _ {
            }
        })
    }
    
    func createArticle(_ articleData: JSON, entityDescription: NSEntityDescription, articlesManagedObjectContext: NSManagedObjectContext) {
        let restArticle = RestArticle(articleData: articleData)
        let publisherEntityDescription = NSEntityDescription.entity(forEntityName: "Publisher", in: articlesManagedObjectContext)
        let publisherFetchRequest = NSFetchRequest<NSFetchRequestResult>()
        publisherFetchRequest.entity = publisherEntityDescription
        let publisherResults = try? articlesManagedObjectContext.fetch(publisherFetchRequest)
        let publishers = publisherResults as! [Publisher]
        for publisherSearch in publishers {
            if publisherSearch.publidherId.intValue == restArticle.publisherId {
                restArticle.publisher = publisherSearch
                break
            }
        }
        let categoryEntityDescription =
        NSEntityDescription.entity(forEntityName: "Category",
            in: articlesManagedObjectContext)
        let categoryFetchRequest = NSFetchRequest<NSFetchRequestResult>()
        categoryFetchRequest.entity = categoryEntityDescription
        let categoryResults = try? articlesManagedObjectContext.fetch(categoryFetchRequest)
        let categories = categoryResults as! [Category]
        for categorySearch in categories {
            if categorySearch.categoriesId.intValue == restArticle.categoryId {
                restArticle.category = categorySearch
                break
            }
        }
        _ = Article(article: restArticle, entity: entityDescription, insertIntoManagedObjectContext: articlesManagedObjectContext)
    }
    
    func updatingArticles() {
        let articlesManagedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.privateQueueConcurrencyType)
        articlesManagedObjectContext.parent = self.managedObjectContext
        let entityDescription = NSEntityDescription.entity(forEntityName: "Article", in: articlesManagedObjectContext)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        fetchRequest.entity = entityDescription
        let results = try? articlesManagedObjectContext.fetch(fetchRequest)
        let articles = results as! [Article]
        api.searchFor(.articles, articleId: nil, completionHandler: { (json: JSON) -> Void in
            if let data = json["data"].array {
                var number: Int = 0
                for index in 0 ..< data.count {
                    for article in articles {
                        if article.articleId.intValue == data[index]["id"].int {
                            number += 1
                        }
                    }
                    if number == 0 {
                        self.createArticle(data[index], entityDescription: entityDescription!, articlesManagedObjectContext: articlesManagedObjectContext)
                    }
                }
            }
            do {
                try articlesManagedObjectContext.save()
            } catch _ {
            }
        })
    }
    
    func getPublishers() {
        let publishersManagedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.privateQueueConcurrencyType)
        publishersManagedObjectContext.parent = self.managedObjectContext
        let entityDescription = NSEntityDescription.entity(forEntityName: "Publisher", in: publishersManagedObjectContext)
        var publishers = [Publisher]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        fetchRequest.entity = entityDescription
        let results = try? publishersManagedObjectContext.fetch(fetchRequest)
        publishers = results as! [Publisher]
        api.searchFor(.publishers, articleId: nil, completionHandler: { (json: JSON) -> Void in
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
                            if publisher.publidherId.intValue == data[index]["id"].int {
                                number += 1
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
    
    func getCategories() {
        let categoriesManagedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.privateQueueConcurrencyType)
        categoriesManagedObjectContext.parent = self.managedObjectContext
        let entityDescription =
        NSEntityDescription.entity(forEntityName: "Category",
            in: categoriesManagedObjectContext)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        fetchRequest.entity = entityDescription
        let results = try? categoriesManagedObjectContext.fetch(fetchRequest)
        let categories = results as! [Category]
        api.searchFor(.categories, articleId: nil, completionHandler: { (json: JSON) -> Void in
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
