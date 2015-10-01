//
//  Publisher.swift
//  Georgia
//
//  Created by MOZI Development on 10/1/15.
//  Copyright (c) 2015 MOZI Development. All rights reserved.
//

import Foundation
import CoreData

class Publisher: NSManagedObject {

    @NSManaged var location: String
    @NSManaged var name: String
    @NSManaged var telephone: NSNumber
    @NSManaged var url: String

}
