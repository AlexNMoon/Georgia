//
//  Categories.swift
//  
//
//  Created by MOZI Development on 10/2/15.
//
//

import Foundation
import CoreData

class Categories: NSManagedObject {

    @NSManaged var categoriesId: NSNumber
    @NSManaged var title: String
    @NSManaged var categIsDeleted: NSNumber
    @NSManaged var isSelected: NSNumber
    @NSManaged var catArticles: NSSet

}
