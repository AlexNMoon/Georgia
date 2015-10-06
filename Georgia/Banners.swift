//
//  Banners.swift
//  
//
//  Created by MOZI Development on 10/6/15.
//
//

import Foundation
import CoreData

class Banners: NSManagedObject {

    @NSManaged var bannerId: NSNumber
    @NSManaged var count: NSNumber
    @NSManaged var image: String
    @NSManaged var link: String
    @NSManaged var title: String

}
