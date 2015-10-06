//
//  Articles.swift
//  
//
//  Created by MOZI Development on 10/6/15.
//
//

import Foundation
import CoreData

class Articles: NSManagedObject {

    @NSManaged var articleId: NSNumber
    @NSManaged var articleIsDeleted: NSNumber
    @NSManaged var categoryId: NSNumber
    @NSManaged var createdAt: NSNumber
    @NSManaged var image: String
    @NSManaged var link: String
    @NSManaged var publisherTime: NSNumber
    @NSManaged var punlisherId: NSNumber
    @NSManaged var status: NSNumber
    @NSManaged var text: String
    @NSManaged var title: String
    @NSManaged var updatedAt: NSNumber
    @NSManaged var video: String
    @NSManaged var category: Categories
    @NSManaged var publisher: Publishers

}
