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
    
    func searchFor(_ urltipe: urlTipe, completionHandler: @escaping (_ json: JSON) -> Void) {
        var searchTerm: String
        switch urltipe {
        case .text:
            searchTerm = "/api/0c08d029-e815-11e6-90ab-1bc4623f1a33"
        case .articles:
            searchTerm = "/api/jsonBlob/fc4f161b-e814-11e6-90ab-b957bfda949e"
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
    
        
}
