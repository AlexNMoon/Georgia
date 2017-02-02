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
        api.searchFor(.text, completionHandler: { (json: JSON) -> Void in
            if let data = json["data"].array {
                for index in 0 ..< data.count {
                    let textData = data[index]
                    if textData["article_id"].int == id {
                        completionHandler(textData)
                    }
                }
            }
        })
        
    }
    
    func getArticles() {
        let selectedCategories = self.getSelectedCategoies()
        let selectedPublishers = self.getSelectedPublishers()
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
        api.searchFor(.articles, completionHandler: { (json: JSON) -> Void in
            if let data = json["data"].array {
                for index in 0 ..< data.count {
                    for categoriesId in selectedCategories {
                        if data[index]["category_id"].int == categoriesId {
                            for publishersId in selectedPublishers {
                                if data[index]["publisher_id"].int == publishersId {
                                    self.createArticle(data[index], entityDescription: entityDescription!, articlesManagedObjectContext: articlesManagedObjectContext)
                                }
                            }
                        }
                    }
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
    
    func getPublishers() {
        let publishersManagedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.privateQueueConcurrencyType)
        publishersManagedObjectContext.parent = self.managedObjectContext
        let entityDescription = NSEntityDescription.entity(forEntityName: "Publisher", in: publishersManagedObjectContext)
        var publishers = [Publisher]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        fetchRequest.entity = entityDescription
        api.searchFor(.publishers, completionHandler: { (json: JSON) -> Void in
            if let data = json["data"].array {
                let results = try? publishersManagedObjectContext.fetch(fetchRequest)
                publishers = results as! [Publisher]
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
        api.searchFor(.categories, completionHandler: { (json: JSON) -> Void in
            if let data = json["data"].array {
                let results = try? categoriesManagedObjectContext.fetch(fetchRequest)
                let categories = results as! [Category]
                if categories.count == 0 {
                    for index in 0 ..< data.count {
                        let categoryData = data[index]
                        let restCategory = RestCategory(categoryData: categoryData)
                        _ = Category(category: restCategory, entity: entityDescription!, insertIntoManagedObjectContext: categoriesManagedObjectContext)
                    }
                } else {
                    var number: Int = 0
                    for index in 0 ..< data.count {
                        for category in categories {
                            if category.categoriesId.intValue == data[index]["id"].int {
                                number += 1
                            }
                        }
                        if number == 0 {
                            let restCategory = RestCategory(categoryData: data[index])
                            _ = Category(category: restCategory, entity: entityDescription!, insertIntoManagedObjectContext: categoriesManagedObjectContext)
                        }
                    }

                }
            }
            do {
                try categoriesManagedObjectContext.save()
            } catch _ {
            }
        })
    }
    
    func getSelectedCategoies() -> [Int] {
        let categoriesManagedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.privateQueueConcurrencyType)
        categoriesManagedObjectContext.parent = self.managedObjectContext
        let entityDescription =
            NSEntityDescription.entity(forEntityName: "Category", in: categoriesManagedObjectContext)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        fetchRequest.entity = entityDescription
        let results = try? categoriesManagedObjectContext.fetch(fetchRequest)
        let categories = results as! [Category]
        var selectedCategories = [Int]()
        for category in categories {
            if category.isSelected == 1 {
                selectedCategories.append(category.categoriesId.intValue)
            }
        }
        if selectedCategories.count == 0 {
            for category in categories {
                selectedCategories.append(category.categoriesId.intValue)
            }
        }
        return selectedCategories
    }
    
    func getSelectedPublishers() ->  [Int] {
        let publishersManagedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.privateQueueConcurrencyType)
        publishersManagedObjectContext.parent = self.managedObjectContext
        let entityDescription = NSEntityDescription.entity(forEntityName: "Publisher", in: publishersManagedObjectContext)
        var publishers = [Publisher]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        fetchRequest.entity = entityDescription
        let results = try? publishersManagedObjectContext.fetch(fetchRequest)
        publishers = results as! [Publisher]
        var selectedPublishers = [Int]()
        for publisher in publishers {
            if publisher.isSelected == 1 {
                selectedPublishers.append(publisher.publidherId.intValue)
            }
        }
        return selectedPublishers
    }

    
}
