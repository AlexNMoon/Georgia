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
    
    let postRequestURL = URL(string: "http://46.101.211.105/v1/devices/ios")
    
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
        case banners
        
    }
    
    enum getCategoryPurpose {
        case get
        case push
    }
    
    func searchFor(_ urltipe: urlTipe, articleId: Int?, completionHandler: (_ json: JSON) -> Void) {
        var searchTerm: String
        switch urltipe {
        case .text:
            searchTerm = "http://46.101.211.105/v1/articles/text/\(articleId!)"
        case .articles:
            searchTerm = "http://46.101.211.105/v1/articles?category_ids=" + self.getSelectedCategoies(.get)! + "&publisher_ids=" + self.getSelectedPublishers()! + "&limit=1000"
        case .publishers:
           searchTerm = "http://46.101.211.105/v1/publishers"
        case .banners:
            searchTerm = "http://46.101.211.105/v1/banners"
        case .categories:
            searchTerm = "http://46.101.211.105/v1/categories"
        }
        let session = URLSession.shared
        let url = URL(string: searchTerm)
        let request = URLRequest(url: url!)
        let dataTask = session.dataTask(with: request, completionHandler: { (data:Data?, response:URLResponse?, error:NSError?) -> Void in
            let json = JSON(data: data!)
            completionHandler(json: json)
            print("\(json.dictionary)")
        } as! (Data?, URLResponse?, Error?) -> Void) 
        dataTask.resume()
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
    
    func putDeviceAPNSToken(_ parametrs: Dictionary<String, String>) {
        let request = NSMutableURLRequest(url: self.postRequestURL!)
        request.httpMethod = "POST"
        request.httpBody = NSKeyedArchiver.archivedData(withRootObject: parametrs)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request, completionHandler: {(data, response, error) in
            print(response)
        });
        task.resume()
    }
    
    func postAPNSSettingsWithParameters(_ parametrs: Dictionary<String, String>) {
        let request = NSMutableURLRequest(url: self.postRequestURL!)
        request.httpMethod = "POST"
        request.httpBody = NSKeyedArchiver.archivedData(withRootObject: parametrs)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request, completionHandler: {(data, response, error) in
            print(response)
        });
        task.resume()
    }

}
