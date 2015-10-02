//
//  Article.swift
//  
//
//  Created by MOZI Development on 10/2/15.
//
//

import Foundation
import CoreData

class Articles: NSManagedObject {

    @NSManaged var video: String
    @NSManaged var text: String
    @NSManaged var title: String
    @NSManaged var articleId: NSNumber
    @NSManaged var punlisherId: NSNumber
    @NSManaged var categoryId: NSNumber
    @NSManaged var publisherTime: NSNumber
    @NSManaged var link: String
    @NSManaged var status: NSNumber
    @NSManaged var image: String
    @NSManaged var articleIsDeleted: NSNumber
    @NSManaged var createdAt: NSNumber
    @NSManaged var updatedAt: NSNumber
    @NSManaged var publisher: Publisher
    @NSManaged var category: NSManagedObject

}
