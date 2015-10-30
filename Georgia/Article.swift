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
    @NSManaged var articleIsDeleted: NSNumber
    @NSManaged var createdAt: NSNumber
    @NSManaged var image: String
    @NSManaged var link: String
    @NSManaged var publisherTime: NSNumber
    @NSManaged var status: NSNumber
    @NSManaged var text: String
    @NSManaged var title: String
    @NSManaged var updatedAt: NSNumber
    @NSManaged var video: String
    @NSManaged var category: Category
    @NSManaged var publisher: Publisher

}

extension Article {
    convenience init(article: RestArticle, entity: NSEntityDescription, insertIntoManagedObjectContext: NSManagedObjectContext?) {
        self.init(entity: entity, insertIntoManagedObjectContext: insertIntoManagedObjectContext)
        if let id = article.articleId {
            self.articleId = id
        }
        if let isDeleted = article.articleIsDeleted {
            self.articleIsDeleted = isDeleted
        }
        if let createdAt = article.createdAt {
            self.createdAt = createdAt
        }
        if let image = article.image {
            self.image = image
        }
        if let link = article.link {
            self.link = link
        }
        if let publisherTime = article.publisherTime {
            self.publisherTime = publisherTime
        }
        if let status = article.status {
            self.status = status
        }
        if let text = article.text {
            self.text = text
        }
        if let title = article.title {
            self.title = title
        }
        if let updatedAt = article.updatedAt {
            self.updatedAt = updatedAt
        }
        if let video = article.video {
            self.video = video
        }
    }
}