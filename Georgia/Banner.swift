//
//  Banners.swift
//  Georgia
//
//  Created by MOZI Development on 10/28/15.
//  Copyright (c) 2015 MOZI Development. All rights reserved.
//

import Foundation
import CoreData

class Banner: NSManagedObject {

    @NSManaged var bannerId: NSNumber
    @NSManaged var count: NSNumber
    @NSManaged var image: String
    @NSManaged var link: String
    @NSManaged var title: String

}
