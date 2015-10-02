//
//  Banners.swift
//  
//
//  Created by MOZI Development on 10/2/15.
//
//

import Foundation
import CoreData

class Banners: NSManagedObject {

    @NSManaged var bannerId: NSNumber
    @NSManaged var title: String
    @NSManaged var image: String
    @NSManaged var link: String
    @NSManaged var count: NSNumber

}
