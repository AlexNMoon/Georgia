//
//  RestCategorie.swift
//  Georgia
//
//  Created by MOZI Development on 10/28/15.
//  Copyright (c) 2015 MOZI Development. All rights reserved.
//

import Foundation
import SwiftyJSON

class RestCategory {
    
    let stringEncoding = StringEncoding()
    
    let categIsDeleted: Int?
    let categoriesId: Int?
    let title: String?
    
    init(categoryData: JSON) {
        if let isDeleted = categoryData["is_deleted"].int {
            self.categIsDeleted = isDeleted
        } else {
            self.categIsDeleted =  nil
        }
        if let id = categoryData["id"].int {
            self.categoriesId = id
        } else {
            self.categoriesId = nil
        }
        if let title = categoryData["title"].string {
            self.title = self.stringEncoding.encoding(title)
        } else {
            self.title = nil
        }
    }
    
}