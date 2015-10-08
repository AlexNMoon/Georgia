//
//  API.swift
//  Georgia
//
//  Created by MOZI Development on 10/2/15.
//  Copyright (c) 2015 MOZI Development. All rights reserved.
//

import Foundation

class API : NSObject, NSURLConnectionDataDelegate, NSURLConnectionDelegate{
    
    let queue:NSOperationQueue = NSOperationQueue()
    
    enum urlTipe {
        case Articles
        case Text
        case Categories
        case Publishers
        
    }
    
    func searchFor(urltipe: urlTipe, completionHandler: (JSONDictionary: NSDictionary) -> Void) {
        var JSONDictionary: NSDictionary!
        var searchTerm: String
        switch urltipe {
        case .Text:
            searchTerm = "http://46.101.211.105/v1/articles/text/2"
        case .Articles:
            searchTerm = "http://46.101.211.105/v1/articles"
        case .Publishers:
           searchTerm = "http://46.101.211.105/v1/publishers"
        default:
           searchTerm = "http://46.101.211.105"
        }
        let url = NSURL(string: searchTerm)
        var request1: NSURLRequest = NSURLRequest(URL: url!)
        NSURLConnection.sendAsynchronousRequest(request1, queue: self.queue, completionHandler:{ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var err: NSError
            var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
            JSONDictionary = jsonResult
            completionHandler(JSONDictionary: JSONDictionary)
            println("AsSynchronous\(JSONDictionary)")
        })
    }

}