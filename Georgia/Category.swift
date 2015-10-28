//
//  Categories.swift
//  Georgia
//
//  Created by MOZI Development on 10/28/15.
//  Copyright (c) 2015 MOZI Development. All rights reserved.
//

import Foundation
import CoreData

class Category: NSManagedObject {

    @NSManaged var categIsDeleted: NSNumber
    @NSManaged var categoriesId: NSNumber
    @NSManaged var isSelected: NSNumber
    @NSManaged var title: String
    @NSManaged var catArticles: NSSet

}
