//
//  Article.swift
//  
//
//  Created by MOZI Development on 9/30/15.
//
//

import Foundation
import CoreData

class Article: NSManagedObject {

    @NSManaged var title: String
    @NSManaged var art: String
    @NSManaged var text: String
    @NSManaged var date: NSDate
    @NSManaged var publisher: String

}
