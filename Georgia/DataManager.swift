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
    
    let api = API()
    
    func getText(completionHandler: (text: String) -> Void) {
        api.searchFor(.Text, completionHandler: { (JSONDictionary: NSDictionary) -> Void in
            if let textDictionary = JSONDictionary["data"] as? NSDictionary {
                if let text = textDictionary["full_description"] as? String {
                completionHandler(text: text)
                }
            }
        })
    }

}
