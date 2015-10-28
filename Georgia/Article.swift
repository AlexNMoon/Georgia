//
//  Articles.swift
//  Georgia
//
//  Created by MOZI Development on 10/28/15.
//  Copyright (c) 2015 MOZI Development. All rights reserved.
//

import Foundation
import CoreData

class Article: NSManagedObject {

    @NSManaged var articleId: NSNumber
    @NSManaged var articleIsDeleted: NSNumber
    @NSManaged var categoryId: NSNumber
    @NSManaged var createdAt: NSNumber
    @NSManaged var image: String
    @NSManaged var link: String
    @NSManaged var publisherTime: NSNumber
    @NSManaged var status: NSNumber
    @NSManaged var text: String
    @NSManaged var title: String
    @NSManaged var updatedAt: NSNumber
    @NSManaged var video: String
    @NSManaged var category: Category
    @NSManaged var publisher: Publisher

}
