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
                        completionHandler(id: articleData["id"] as! Int, title: NSAttributedString(data: title.dataUsingEncoding(NSUTF8StringEncoding)!, options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,NSCharacterEncodingDocumentAttribute:NSUTF8StringEncoding], documentAttributes: nil, error: nil)!.string)
                    }
                }
            }
        })
    }
    
    func getPublishers(index: Int, completionHandler: (id: Int, name: String, logoURL: String) -> Void) {
        api.searchFor(.Publishers, completionHandler: { (JSONDictionary: NSDictionary) -> Void in
            if let data = JSONDictionary["data"] as? [AnyObject] {
                if let publisher = data[index] as? NSDictionary {
                    if let logo = publisher["logo"] as? String {
                        completionHandler(id: publisher["id"] as! Int, name: publisher["publisher_name"] as! String, logoURL: logo)
                    }
                }
            }
        })
        
    }
    
    
}
