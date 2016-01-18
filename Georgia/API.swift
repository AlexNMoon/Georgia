//
//  API.swift
//  Georgia
//
//  Created by MOZI Development on 10/2/15.
//  Copyright (c) 2015 MOZI Development. All rights reserved.
//

import Foundation
import SwiftyJSON
import CoreData

class API : NSObject, NSURLConnectionDataDelegate, NSURLConnectionDelegate{
    
    let queue:NSOperationQueue = NSOperationQueue()
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    enum urlTipe {
        case Articles
        case Text
        case Categories
        case Publishers
        case Banners
        
    }
    
    func searchFor(urltipe: urlTipe, articleId: Int?, completionHandler: (json: JSON) -> Void) {
        var searchTerm: String
        switch urltipe {
        case .Text:
            searchTerm = "http://46.101.211.105/v1/articles/text/\(articleId!)"
        case .Articles:
            searchTerm = "http://46.101.211.105/v1/articles?"
            var commas: Bool
            let categoryEntityDescription =
            NSEntityDescription.entityForName("Category",
                inManagedObjectContext: self.managedObjectContext!)
            let categoryFetchRequest = NSFetchRequest()
            categoryFetchRequest.entity = categoryEntityDescription
            let categoryResults = try? self.managedObjectContext!.executeFetchRequest(categoryFetchRequest)
            let categories = categoryResults as! [Category]
            searchTerm += "category_ids="
            commas = false
            var categoriesCount: Int = 0
            for category in categories {
                if category.isSelected == 1 {
                    ++categoriesCount
                }
            }
            if categoriesCount > 0 {
                for category in categories {
                    if category.isSelected == 1 {
                        if commas {
                            searchTerm += ","
                            commas = false
                        }
                        searchTerm += "\(category.categoriesId)"
                        commas = true
                    }
                }

            } else {
                for category in categories {
                    if commas {
                        searchTerm += ","
                        commas = false
                    }
                    searchTerm += "\(category.categoriesId)"
                    commas = true
                }

            }
            searchTerm += "&publisher_ids="
            let publisherEntityDescription = NSEntityDescription.entityForName("Publisher", inManagedObjectContext: self.managedObjectContext!)
            var publishers = [Publisher]()
            let publisherFetchRequest = NSFetchRequest()
            publisherFetchRequest.entity = publisherEntityDescription
            let publisherResults = try? self.managedObjectContext!.executeFetchRequest(publisherFetchRequest)
            publishers = publisherResults as! [Publisher]
            commas = false
            for publisher in publishers {
                if publisher.isSelected == 1 {
                    if commas {
                        searchTerm += ","
                    }
                    searchTerm += "\(publisher.publidherId)"
                    commas = true
                }
            }
            searchTerm += "&limit=1000"
        case .Publishers:
           searchTerm = "http://46.101.211.105/v1/publishers"
        case .Banners:
            searchTerm = "http://46.101.211.105/v1/banners"
        case .Categories:
            searchTerm = "http://46.101.211.105/v1/categories"
        }
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: searchTerm)
        let request = NSURLRequest(URL: url!)
        let dataTask = session.dataTaskWithRequest(request) { (data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
            let json = JSON(data: data!)
            completionHandler(json: json)
            print("\(json.dictionary)")
        }
        dataTask.resume()
    }

}