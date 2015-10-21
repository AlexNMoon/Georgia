//
//  Categories.swift
//  
//
//  Created by MOZI Development on 10/7/15.
//
//

import Foundation
import CoreData

@objc(Categories)

class Categories: NSManagedObject {

    @NSManaged var categIsDeleted: NSNumber
    @NSManaged var categoriesId: NSNumber
    @NSManaged var isSelected: NSNumber
    @NSManaged var title: String
    @NSManaged var catArticles: NSSet

}
