//
//  Publishers.swift
//  Georgia
//
//  Created by MOZI Development on 10/28/15.
//  Copyright (c) 2015 MOZI Development. All rights reserved.
//

import Foundation
import CoreData

class Publisher: NSManagedObject {

    @NSManaged var address: String
    @NSManaged var createdAt: NSNumber
    @NSManaged var email: String
    @NSManaged var isSelected: NSNumber
    @NSManaged var logo: String
    @NSManaged var name: String
    @NSManaged var publDescription: String
    @NSManaged var publidherId: NSNumber
    @NSManaged var publIsDeleted: NSNumber
    @NSManaged var site: String
    @NSManaged var telephone: String
    @NSManaged var updatedAt: NSNumber
    @NSManaged var pubArticles: NSSet

}
