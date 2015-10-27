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
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    let api = API()
    
    var publishers = [NSManagedObject]()
    
    func getText(completionHandler: (text: String) -> Void) {
        api.searchFor(.Text, completionHandler: { (JSONDictionary: NSDictionary) -> Void in
            if let data = JSONDictionary["data"] as? NSDictionary {
                if let text = data["full_description"] as? String {
                completionHandler(text: NSAttributedString(data: text.dataUsingEncoding(NSUTF8StringEncoding)!, options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,NSCharacterEncodingDocumentAttribute:NSUTF8StringEncoding], documentAttributes: nil, error: nil)!.string)
                }
            }
        })
    }
    
    func getArticles(completionHandler: (articles: [NSManagedObject]) -> Void) {
        let entityDescription =
        NSEntityDescription.entityForName("Articles",
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
                let entity = NSEntityDescription.entityForName("Articles", inManagedObjectContext: self.managedObjectContext!)
                if let data = JSONDictionary["data"] as? [AnyObject] {
                    for index in 0 ..< data.count {
                        let article = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: self.managedObjectContext) as! Articles
                        if let articleData = data[index] as? NSDictionary {
                            if let id = articleData["id"] as? Int {
                                article.setValue(id, forKey: "articleId")
                            }
                            if let isDeleted = articleData["is_deleted"] as? Int {
                                article.setValue(isDeleted, forKey: "articleIsDeleted")
                            }
                            if let createdAt = articleData["created_at"] as? Int {
                                article.setValue(createdAt, forKey: "createdAt")
                            }
                            if let title = articleData["title"] as? String {
                                article.setValue(title, forKey: "title")
                            }
                            if let publisherId = articleData["publisher_id"] as? Int {
                                for indexPubl in 0 ..< self.publishers.count {
                                    if self.publishers[indexPubl].valueForKey("publidherId") as? Int == publisherId {
                                        article.setValue(self.publishers[indexPubl], forKey: "publisher")
                                        let articlesSet = self.publishers[indexPubl].valueForKey("pubArticles") as! NSSet
                                        var articlesArray = articlesSet.allObjects
                                        articlesArray.append(article)
                                        self.publishers[indexPubl].setValue(
                                            "", forKey: "pubArticles")
                                        break
                                    }
                                }
                                
                            }
                            if let publisherTime = articleData["publisher_time"] as? Int {
                                article.setValue(publisherTime, forKey: "publisherTime")
                            }
                            if let status = articleData["status"] as? Int {
                                article.setValue(status, forKey: "status")
                            }
                            if let image = articleData["image"] as? String {
                                article.setValue(image, forKey: "image")
                            }
                            if let link = articleData["link"] as? String {
                                article.setValue(link, forKey: "link")
                            }
                            if let updatedAt = articleData["updated_at"] as? Int {
                                article.setValue(updatedAt, forKey: "updatedAt")
                            }
                            if let video = articleData["video"] as? String {
                                article.setValue(video, forKey: "video")
                            }
                        }
                        
                    }
                }
            self.managedObjectContext?.save(nil)
            let articlesDownload = self.managedObjectContext?.executeFetchRequest(fetchRequest, error: nil) as! [NSManagedObject]
            completionHandler(articles: articlesDownload)
        })
    }
    
    func getPublishers(completionHandler: (publishers: [NSManagedObject]) -> Void) {
        let entityDescription =
            NSEntityDescription.entityForName("Publishers",
                inManagedObjectContext: managedObjectContext!)
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity = entityDescription
        let results = managedObjectContext?.executeFetchRequest(fetchRequest, error: nil)
        self.publishers = results as! [NSManagedObject]
        api.searchFor(.Publishers, completionHandler: { (JSONDictionary: NSDictionary) -> Void in
            if self.publishers.count == 0 {
                let entity = NSEntityDescription.entityForName("Publishers", inManagedObjectContext: self.managedObjectContext!)
                if let data = JSONDictionary["data"] as? [AnyObject] {
                    for index in 0 ..< data.count {
                        let publisher = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: self.managedObjectContext) as! Publishers
                        if let publisherData = data[index] as? NSDictionary{
                            if let address = publisherData["address"] as? String {
                                publisher.setValue(NSAttributedString(data: address.dataUsingEncoding(NSUTF8StringEncoding)!, options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,NSCharacterEncodingDocumentAttribute:NSUTF8StringEncoding], documentAttributes: nil, error: nil)!.string, forKey: "address")
                            }
                            if let description = publisherData["description"] as? String {
                                publisher.setValue(NSAttributedString(data: description.dataUsingEncoding(NSUTF8StringEncoding)!, options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,NSCharacterEncodingDocumentAttribute:NSUTF8StringEncoding], documentAttributes: nil, error: nil)!.string, forKey: "publDescription")
                            }
                            if let email = publisherData["email"] as? String {
                                publisher.setValue(email, forKey: "email")
                            }
                            if let id = publisherData["id"] as? Int {
                                publisher.setValue(id, forKey: "publidherId")
                            }
                            if let isDeleted = publisherData["is_deleted"] as? Int{
                                publisher.setValue(isDeleted, forKey: "publIsDeleted")
                            }
                            if let logo = publisherData["logo"] as? String {
                                publisher.setValue(logo, forKey: "logo")
                            }
                            if let phone = publisherData["phone"] as? String {
                                publisher.setValue(phone, forKey: "telephone")
                            }
                            if let name = publisherData["publisher_name"] as? String {
                                publisher.setValue(NSAttributedString(data: name.dataUsingEncoding(NSUTF8StringEncoding)!, options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,NSCharacterEncodingDocumentAttribute:NSUTF8StringEncoding], documentAttributes: nil, error: nil)!.string, forKey: "name")
                            }
                            if let site = publisherData["site"] as? String {
                                publisher.setValue(site, forKey: "site")
                            }
                            if let createdAt = publisherData["created_at"] as? Int {
                                publisher.setValue(createdAt, forKey: "createdAt")
                            }
                            if let updatedAt = publisherData["updated_at"] as? Int {
                                publisher.setValue(updatedAt, forKey: "updatedAt")
                            }
                            publisher.setValue([], forKey: "pubArticles")
                        }
                    }
                    self.managedObjectContext?.save(nil)
                    let publishersFirstDownload = self.managedObjectContext?.executeFetchRequest(fetchRequest, error: nil) as! [NSManagedObject]
                    completionHandler(publishers: publishersFirstDownload)
                    self.publishers = publishersFirstDownload
                } 
            } else {
                completionHandler(publishers: self.publishers)
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
