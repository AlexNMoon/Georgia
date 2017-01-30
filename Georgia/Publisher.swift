//
//  Publishers.swift
//  Georgia
//
//  Created by MOZI Development on 10/28/15.
//  Copyright (c) 2015 MOZI Development. All rights reserved.
//

import Foundation
import CoreData

@objc(Publisher)

class Publisher: NSManagedObject {

    @NSManaged var address: String?
    @NSManaged var createdAt: NSNumber?
    @NSManaged var email: String?
    @NSManaged var isSelected: NSNumber?
    @NSManaged var logo: String?
    @NSManaged var name: String?
    @NSManaged var publDescription: String?
    @NSManaged var publidherId: NSNumber
    @NSManaged var publIsDeleted: NSNumber?
    @NSManaged var site: String?
    @NSManaged var telephone: String?
    @NSManaged var updatedAt: NSNumber?
    @NSManaged var stream: String?
    @NSManaged var pubArticles: NSSet

}


extension Publisher {
     convenience init(publisher: RestPublisher, entity: NSEntityDescription, insertIntoManagedObjectContext: NSManagedObjectContext?) {
        self.init(entity: entity, insertInto: insertIntoManagedObjectContext)
        if let address = publisher.address {
            self.address = address
        }
        if let createdAt = publisher.createdAt {
        self.createdAt = createdAt as NSNumber?
        }
        if let email = publisher.email {
        self.email = email
        }
        if let logo = publisher.logo {
            self.logo = logo
        }
        if let name = publisher.name {
            self.name = name
        }
        if let description = publisher.publDescription {
            self.publDescription = description
        }
        if let id = publisher.publisherId {
            self.publidherId = NSNumber(id)
        }
        if let isDeleted = publisher.publIsDeleted {
            self.publIsDeleted = NSNumber(value: isDeleted as Bool)
        }
        if let site = publisher.site {
            self.site = site
        }
        if let telephone = publisher.telephone {
            self.telephone = telephone
        }
        if let updatedAt = publisher.updatedAt {
            self.updatedAt = updatedAt as NSNumber?
        }
        if let stream = publisher.stream {
            self.stream = stream
        }
    }
    
}
