//
//  DataManager.swift
//  Georgia
//
//  Created by MOZI Development on 10/2/15.
//  Copyright (c) 2015 MOZI Development. All rights reserved.
//

import Foundation
import CoreData

class DataManager {
    
    let stringEncoding = StringEncoding()
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    let api = API()
    
    
    
    func getText(id: Int) -> String? {
        var text: String? = nil
        api.searchFor(.Text, completionHandler: { (JSONDictionary: NSDictionary) -> Void in
            if let data = JSONDictionary["data"] as? NSDictionary {
                if let textData = data["full_description"] as? String {
                     text = self.stringEncoding.encoding(textData)
                }
            }
        })
        return text
    }
    
    func getArticles() {
        let entityDescription =
        NSEntityDescription.entityForName("Article",
            inManagedObjectContext: managedObjectContext!)
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity = entityDescription
        let results = managedObjectContext?.executeFetchRequest(fetchRequest, error: nil)
        let articles = results as! [NSManagedObject]
        for index in 0 ..< articles.count {
            self.managedObjectContext?.deleteObject(articles[index])
        }
        self.managedObjectContext?.save(nil)
        api.searchFor(.Articles, completionHandler: { (JSONDictionary: NSDictionary) -> Void in
            var articlesResult: [Article] = []
            if let data = JSONDictionary["data"] as? [AnyObject] {
                for index in 0 ..< data.count {
                    if let articleData = data[index] as? NSDictionary {
                        let restArticle = RestArticle(articleData: articleData)
                        let article = Article(article: restArticle, entity: entityDescription!, insertIntoManagedObjectContext: self.managedObjectContext)
                        articlesResult.append(article)
                    }
                }
            }
            self.managedObjectContext?.save(nil)
        })
    }
    
    func getPublishers(publisherIndex: Int?, completionHandler: (publisherForArticle: Publisher) -> Void) {
        let entityDescription = NSEntityDescription.entityForName("Publisher", inManagedObjectContext: managedObjectContext!)
        var publishers = [Publisher]()
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity = entityDescription
        let results = managedObjectContext?.executeFetchRequest(fetchRequest, error: nil)
        publishers = results as! [Publisher]
        if let publIndex = publisherIndex {
            for publisher in publishers {
                if publisher.publidherId == publIndex {
                    completionHandler(publisherForArticle: publisher)
                    break
                }
            }
        } else {
        api.searchFor(.Publishers, completionHandler: { (JSONDictionary: NSDictionary) -> Void in
            if publishers.count == 0 {
                if let data = JSONDictionary["data"] as? [AnyObject] {
                    for index in 0 ..< data.count {
                        if let publisherData = data[index] as? NSDictionary{
                            let restPublisher = RestPublisher(publisherData: publisherData)
                            let publisher = Publisher(publisher: restPublisher, entity: entityDescription!, insertIntoManagedObjectContext: self.managedObjectContext)
                        }
                    }
                    self.managedObjectContext?.save(nil)
                }
            } else {
                
            }
        })
        }
    }
    
    func getBanners(completitionHandler: (image: UIImage?) ->  Void) {
        let entityDescription =
        NSEntityDescription.entityForName("Banner",
            inManagedObjectContext: managedObjectContext!)
        api.searchFor(.Banners, completionHandler: { ( JSONDictionary: NSDictionary) -> Void in
            if let data = JSONDictionary["data"] as? [AnyObject] {
                if data.count == 0 {
                    completitionHandler(image: UIImage(named: "launch_background.png")!)
                } else {
                    for index in 0 ..< data.count {
                        if let bannerData = data[index] as? NSDictionary {
                            let restBanner = RestBanner(bannerData: bannerData)
                            let banner = Banner(banner: restBanner, entity: entityDescription!, insertIntoManagedObjectContext: self.managedObjectContext)
                        }
                    }
                    self.managedObjectContext?.save(nil)
                }
            }
        })
    }
    
    func getCategories(categoryIndex: Int?, completionHandler: (categoryForArticle: Category) -> Void) {
        let entityDescription =
        NSEntityDescription.entityForName("Category",
            inManagedObjectContext: managedObjectContext!)
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity = entityDescription
        let results = managedObjectContext?.executeFetchRequest(fetchRequest, error: nil)
        let categories = results as! [Category]
        if let categIndex = categoryIndex {
            for category in categories {
                if category.categoriesId == categIndex {
                    completionHandler(categoryForArticle: category)
                    break
                }
            }
        } else {
        api.searchFor(.Categories, completionHandler: { (JSONDictionary: NSDictionary) -> Void in
            if let data = JSONDictionary["data"] as? [AnyObject] {
                for index in 0 ..< data.count {
                if let categoryData = data[index] as? NSDictionary {
                    let restCategory = RestCategory(categoryData: categoryData)
                    let category = Category(category: restCategory, entity: entityDescription!, insertIntoManagedObjectContext: self.managedObjectContext)
                }
                }
            }
        })
        }
    }
    
    
}
