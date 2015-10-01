//
//  Article.swift
//  Georgia
//
//  Created by MOZI Development on 10/1/15.
//  Copyright (c) 2015 MOZI Development. All rights reserved.
//

import Foundation
import CoreData

class Article: NSManagedObject {

    @NSManaged var art: String
    @NSManaged var date: NSDate
    @NSManaged var publisher: String
    @NSManaged var text: String
    @NSManaged var title: String

}
