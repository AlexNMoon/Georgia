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
    
    //let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var managedObjectContext: NSManagedObjectContext?
    
    let postRequestURL = NSURL(string: "http://46.101.211.105/v1/devices/ios")
    
    override init() {
        super.init()
        if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
            self.managedObjectContext = appDelegate.managedObjectContext!
        }
        else {
            self.managedObjectContext = nil
        }
    }

    enum urlTipe {
        case Articles
        case Text
        case Categories
        case Publishers
        case Banners
        
    }
    
    enum getCategoryPurpose {
        case Get
        case Push
    }
    
    func searchFor(urltipe: urlTipe, articleId: Int?, completionHandler: (json: JSON) -> Void) {
        var searchTerm: String
        switch urltipe {
        case .Text:
            searchTerm = "http://46.101.211.105/v1/articles/text/\(articleId!)"
        case .Articles:
            searchTerm = "http://46.101.211.105/v1/articles?category_ids=" + self.getSelectedCategoies(.Get)! + "&publisher_ids=" + self.getSelectedPublishers()! + "&limit=1000"
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
    
    func getSelectedCategoies(purpose: getCategoryPurpose) -> String? {
        var commas = false
        var result = ""
        let categoryEntityDescription = NSEntityDescription.entityForName("Category", inManagedObjectContext: self.managedObjectContext!)
        let categoryFetchRequest = NSFetchRequest()
        categoryFetchRequest.entity = categoryEntityDescription
        let categoryResults = try? self.managedObjectContext!.executeFetchRequest(categoryFetchRequest)
        let categories = categoryResults as! [Category]
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
            case .Get:
                for category in categories {
                    if commas {
                        result += ","
                        commas = false
                    }
                    result += "\(category.categoriesId)"
                    commas = true
                }
                return result
            case .Push:
                return nil
            }
        }
    }
    
    func getSelectedPublishers() -> String? {
        var commas = false
        var result = ""
        let publisherEntityDescription = NSEntityDescription.entityForName("Publisher", inManagedObjectContext: self.managedObjectContext!)
        var publishers = [Publisher]()
        let publisherFetchRequest = NSFetchRequest()
        publisherFetchRequest.entity = publisherEntityDescription
        let publisherResults = try? self.managedObjectContext!.executeFetchRequest(publisherFetchRequest)
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
    
    func putDeviceAPNSToken(parametrs: Dictionary<String, String>) {
        let request = NSMutableURLRequest(URL: self.postRequestURL!)
        request.HTTPMethod = "POST"
        request.HTTPBody = NSKeyedArchiver.archivedDataWithRootObject(parametrs)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        let task = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            print(response)
        });
        task.resume()
    }
    
    func postAPNSSettingsWithParameters(parametrs: Dictionary<String, String>) {
        let request = NSMutableURLRequest(URL: self.postRequestURL!)
        request.HTTPMethod = "POST"
        request.HTTPBody = NSKeyedArchiver.archivedDataWithRootObject(parametrs)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        let task = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            print(response)
        });
        task.resume()
    }

}