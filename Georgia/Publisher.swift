//
//  Publisher.swift
//  
//
//  Created by MOZI Development on 9/30/15.
//
//

import Foundation
import CoreData

class Publisher: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var telephone: NSNumber
    @NSManaged var url: String

}
