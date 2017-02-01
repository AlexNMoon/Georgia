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
    
    let queue:OperationQueue = OperationQueue()
    
    var managedObjectContext: NSManagedObjectContext?
    
    override init() {
        super.init()
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            self.managedObjectContext = appDelegate.managedObjectContext!
        }
        else {
            self.managedObjectContext = nil
        }
    }

    enum urlTipe {
        case articles
        case text
        case categories
        case publishers
    }
    
    enum getCategoryPurpose {
        case get
        case push
    }
    
    func searchFor(_ urltipe: urlTipe, articleId: Int?, completionHandler: @escaping (_ json: JSON) -> Void) {
        var searchTerm: String
        switch urltipe {
        case .text:
            searchTerm = "/api/0c08d029-e815-11e6-90ab-1bc4623f1a33/v1?article_id=\(articleId!)"
        case .articles:
            searchTerm = "/api/jsonBlob/fc4f161b-e814-11e6-90ab-b957bfda949e/category_id=" + self.getSelectedCategoies(.get)! + "&publisher_id=" + self.getSelectedPublishers()!
        case .publishers:
           searchTerm = "/api/jsonBlob/90d6a4ba-e812-11e6-90ab-fd49707f3a32"
        case .categories:
            searchTerm = "/api/jsonBlob/8dee6837-e7d9-11e6-90ab-e3a3cf1c892d"
        }
        let session = URLSession.shared
        let url = NSURL(scheme: "http", host: "jsonblob.com", path: searchTerm)
        let request = URLRequest(url: url! as URL)
        _ = session.dataTask(with: request) { (data, response, error) in
            let json = JSON(data: data!)
            completionHandler(json)
            print("\(json.dictionary)")
        }.resume()
        
        
    }
    
    func getSelectedCategoies(_ purpose: getCategoryPurpose) -> String? {
        var commas = false
        var result = ""
        let categoryEntityDescription = NSEntityDescription.entity(forEntityName: "Category", in: self.managedObjectContext!)
        let categoryFetchRequest = NSFetchRequest<NSFetchRequestResult>()
        categoryFetchRequest.entity = categoryEntityDescription
        let categoryResults = try? self.managedObjectContext!.fetch(categoryFetchRequest)
        let categories = categoryResults as! [Category]
        var categoriesCount: Int = 0
        for category in categories {
            if category.isSelected == 1 {
                categoriesCount += 1
            }
        }
        if categoriesCount > 0 {
            for category in categories {
                if category.isSelected == 1 {
                    if commas {
                        result += ","
                        commas = false
                    }
                    result += "\(category.categoriesId)"
                    commas = true
                }
            }
            return result
        } else {
            switch purpose {
            case .get:
                for category in categories {
                    if commas {
                        result += ","
                        commas = false
                    }
                    result += "\(category.categoriesId)"
                    commas = true
                }
                return result
            case .push:
                return nil
            }
        }
    }
    
    func getSelectedPublishers() -> String? {
        var commas = false
        var result = ""
        let publisherEntityDescription = NSEntityDescription.entity(forEntityName: "Publisher", in: self.managedObjectContext!)
        var publishers = [Publisher]()
        let publisherFetchRequest = NSFetchRequest<NSFetchRequestResult>()
        publisherFetchRequest.entity = publisherEntityDescription
        let publisherResults = try? self.managedObjectContext!.fetch(publisherFetchRequest)
        publishers = publisherResults as! [Publisher]
        for publisher in publishers {
            if publisher.isSelected == 1 {
                if commas {
                    result += ","
                }
                result += "\(publisher.publidherId)"
                commas = true
            }
        }
        return result
    }
    
}
