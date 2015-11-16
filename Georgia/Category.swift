//
//  Categories.swift
//  Georgia
//
//  Created by MOZI Development on 10/28/15.
//  Copyright (c) 2015 MOZI Development. All rights reserved.
//

import Foundation
import CoreData

@objc(Category)

class Category: NSManagedObject {

    @NSManaged var categIsDeleted: NSNumber?
    @NSManaged var categoriesId: NSNumber
    @NSManaged var isSelected: NSNumber?
    @NSManaged var title: String?
    @NSManaged var catArticles: NSSet?

}

extension Category {
    convenience init(category: RestCategory, entity: NSEntityDescription, insertIntoManagedObjectContext: NSManagedObjectContext?) {
        self.init(entity: entity, insertIntoManagedObjectContext: insertIntoManagedObjectContext)
        if let isDeleted = category.categIsDeleted {
            self.categIsDeleted = isDeleted
        }
        if let id = category.categoriesId {
            self.categoriesId = id
        }
        if let title = category.title {
            self.title = title
        }
    }
}