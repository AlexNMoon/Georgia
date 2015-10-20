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
    
    func getText(completionHandler: (text: String) -> Void) {
        api.searchFor(.Text, completionHandler: { (JSONDictionary: NSDictionary) -> Void in
            if let data = JSONDictionary["data"] as? NSDictionary {
                if let text = data["full_description"] as? String {
                completionHandler(text: NSAttributedString(data: text.dataUsingEncoding(NSUTF8StringEncoding)!, options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,NSCharacterEncodingDocumentAttribute:NSUTF8StringEncoding], documentAttributes: nil, error: nil)!.string)
                }
            }
        })
    }
    
    func getArticles(completionHandler: (id: Int, title: String) -> Void) {
        api.searchFor(.Articles, completionHandler: { (JSONDictionary: NSDictionary) -> Void in
            if let data = JSONDictionary["data"] as? [AnyObject] {
                if let articleData = data[0] as? NSDictionary {
                    if let title = articleData["title"] as? String {
                        completionHandler(id: articleData["id"] as! Int, title: title)
                    }
                }
            }
        })
    }
    
    func getPublishers(completionHandler: (publishers: [NSManagedObject]) -> Void) {
        let fetchRequest = NSFetchRequest(entityName: "Publishers")
        let results = managedObjectContext?.executeFetchRequest(fetchRequest, error: nil)
        let publishers = results as! [NSManagedObject]
        api.searchFor(.Publishers, completionHandler: { (JSONDictionary: NSDictionary) -> Void in
            if publishers.count == 0 {
                let entity = NSEntityDescription.entityForName("Publishers", inManagedObjectContext: self.managedObjectContext!)
                if let data = JSONDictionary["data"] as? [AnyObject] {
                    for index in 0 ..< data.count {
                        let publisher = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: self.managedObjectContext)
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
                            if let updetedAt = publisherData["updated_at"] as? Int {
                                publisher.setValue(updetedAt, forKey: "updetedAt")
                            }
                        }
                    }
                }
            }
        })
        managedObjectContext?.save(nil)
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
