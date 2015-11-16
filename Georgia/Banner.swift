//
//  Banners.swift
//  Georgia
//
//  Created by MOZI Development on 10/28/15.
//  Copyright (c) 2015 MOZI Development. All rights reserved.
//

import Foundation
import CoreData

@objc(Banner)

class Banner: NSManagedObject {

    @NSManaged var bannerId: NSNumber
    @NSManaged var count: NSNumber?
    @NSManaged var image: String?
    @NSManaged var link: String?
    @NSManaged var title: String?

}

extension Banner {
    convenience init(banner: RestBanner, entity: NSEntityDescription, insertIntoManagedObjectContext: NSManagedObjectContext?) {
        self.init(entity: entity, insertIntoManagedObjectContext: insertIntoManagedObjectContext)
        if let id = banner.bannerId {
            self.bannerId = id
        }
        if let image = banner.image {
            self.image = image
        }
        if let link = banner.link {
            self.link = link
        }
        if let title = banner.title {
            self.title = title
        }
    }
}