//
//  Publishers.swift
//  
//
//  Created by MOZI Development on 10/7/15.
//
//

import Foundation
import CoreData

class Publishers: NSManagedObject {

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
    @NSManaged var url: String
    @NSManaged var pubArticles: NSSet
    @NSManaged var address: String

}
