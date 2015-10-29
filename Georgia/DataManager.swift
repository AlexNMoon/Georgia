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
                        let article = Article(article: restArticle)
                        articlesResult.append(article)
                    }
                }
            }
            self.managedObjectContext?.save(nil)
        })
    }
    
    func getPublishers() {
        var publishers = [Publisher]()
        let entityDescription =
            NSEntityDescription.entityForName("Publisher",
                inManagedObjectContext: managedObjectContext!)
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity = entityDescription
        let results = managedObjectContext?.executeFetchRequest(fetchRequest, error: nil)
        publishers = results as! [Publisher]
        api.searchFor(.Publishers, completionHandler: { (JSONDictionary: NSDictionary) -> Void in
            if publishers.count == 0 {
                if let data = JSONDictionary["data"] as? [AnyObject] {
                    for index in 0 ..< data.count {
                        if let publisherData = data[index] as? NSDictionary{
                            let restPublisher = RestPublisher(publisherData: publisherData)
                            let publisher = Publisher(publisher: restPublisher)
                            publishers.append(publisher)
                        }
                    }
                    self.managedObjectContext?.save(nil)
                }
            } else {
                
            }
        })
        
    }
    
    func getBanners(completitionHandler: (image: UIImage) ->  Void) {
        api.searchFor(.Banners, completionHandler: { ( JSONDictionary: NSDictionary) -> Void in
            if let data = JSONDictionary["data"] as? [AnyObject] {
                if data.count == 0 {
                    completitionHandler(image: UIImage(named: "launch_background.png")!)
                } else {
                    if let bannerData = data[0] as? NSDictionary {
                        if let image = bannerData["image"] as? String {
                            completitionHandler(image: UIImage(named: image)!)
                        }
                    }
                }
            }
        })
    }
    
    func getCategories(index: Int, completitionHandler: (name: String) -> Void) {
        api.searchFor(.Categories, completionHandler: { (JSONDictionary: NSDictionary) -> Void in
            if let data = JSONDictionary["data"] as? [AnyObject] {
                if let categoryData = data[index] as? NSDictionary {
                    let name = NSAttributedString(data: categoryData["title"]!.dataUsingEncoding(NSUTF8StringEncoding)!, options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,NSCharacterEncodingDocumentAttribute:NSUTF8StringEncoding], documentAttributes: nil, error: nil)!.string
                    completitionHandler(name: name)
                }
            }
        })
    }
    
    
}
