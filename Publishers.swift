//
//  Publisher.swift
//  
//
//  Created by MOZI Development on 10/2/15.
//
//

import Foundation
import CoreData

class Publishers: NSManagedObject {

    @NSManaged var updatedAt: NSNumber
    @NSManaged var name: String
    @NSManaged var telephone: NSNumber
    @NSManaged var url: String
    @NSManaged var logo: String
    @NSManaged var publidherId: NSNumber
    @NSManaged var publDescription: String
    @NSManaged var site: String
    @NSManaged var email: String
    @NSManaged var publIsDeleted: NSNumber
    @NSManaged var createdAt: NSNumber
    @NSManaged var isSelected: NSNumber
    @NSManaged var pubArticles: NSSet

}
