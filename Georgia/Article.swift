//
//  Articles.swift
//  Georgia
//
//  Created by MOZI Development on 10/28/15.
//  Copyright (c) 2015 MOZI Development. All rights reserved.
//

import Foundation
import CoreData

@objc(Article)

class Article: NSManagedObject {

    @NSManaged var articleId: NSNumber
    @NSManaged var articleIsDeleted: NSNumber?
    @NSManaged var createdAt: NSNumber?
    @NSManaged var image: String?
    @NSManaged var link: String?
    @NSManaged var publisherTime: NSNumber?
    @NSManaged var status: NSNumber?
    @NSManaged var title: String?
    @NSManaged var updatedAt: NSNumber?
    @NSManaged var video: String?
    @NSManaged var category: Category
    @NSManaged var publisher: Publisher

}

extension Article {
    convenience init(article: RestArticle, entity: NSEntityDescription, insertIntoManagedObjectContext: NSManagedObjectContext?) {
        self.init(entity: entity, insertInto: insertIntoManagedObjectContext)
        
        if let id = article.articleId {
            self.articleId = NSNumber(value: id)
        }
        if let isDeleted = article.articleIsDeleted {
            self.articleIsDeleted = NSNumber(value: isDeleted as Bool)
        }
        if let createdAt = article.createdAt {
            self.createdAt = createdAt as NSNumber?
        }
        if let image = article.image {
            self.image = image
        }
        if let link = article.link {
            self.link = link
        }
        if let publisherTime = article.publisherTime {
            self.publisherTime = publisherTime as NSNumber?
        }
        if let status = article.status {
            self.status = NSNumber(value: status as Bool)
        }
        if let title = article.title {
            self.title = title
        }
        if let updatedAt = article.updatedAt {
            self.updatedAt = updatedAt as NSNumber?
        }
        if let video = article.video {
            self.video = video
        }
        if let publisher = article.publisher {
            self.publisher = publisher
        }
        if let category = article.category {
            self.category = category
        }
    }
}
