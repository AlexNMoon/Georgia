//
//  Banners.swift
//  
//
//  Created by MOZI Development on 10/7/15.
//
//

import Foundation
import CoreData

@objc(Banners)

class Banners: NSManagedObject {

    @NSManaged var bannerId: NSNumber
    @NSManaged var count: NSNumber
    @NSManaged var image: String
    @NSManaged var link: String
    @NSManaged var title: String

}
