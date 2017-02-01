//
//  RestArticle.swift
//  Georgia
//
//  Created by MOZI Development on 10/28/15.
//  Copyright (c) 2015 MOZI Development. All rights reserved.
//

import Foundation
import SwiftyJSON

class RestArticle {
    
    let dataManager = DataManager()
    
    var articleId: Int? = nil
    var articleIsDeleted: Bool? = nil
    var createdAt: Int? = nil
    var image: String? = nil
    var link: String? = nil
    var publisherTime: Int? = nil
    var status: Bool? = nil
    var title: String? = nil
    var updatedAt: Int? = nil
    var video: String? = nil
    var categoryId: Int? = nil
    var publisherId: Int? = nil
    var category: Category? = nil
    var publisher: Publisher? = nil
    
    init(articleData: JSON) {
        if let id = articleData["id"].int {
            self.articleId = id
        }
        if let isDeleted = articleData["is_deleted"].bool {
            self.articleIsDeleted = isDeleted
        }
        if let createdAt = articleData["created_at"].int {
            self.createdAt = createdAt
        }
        if let title = articleData["title"].string {
            self.title = title
        }
        if let publisherId = articleData["publisher_id"].int {
            self.publisherId = publisherId
        }
        if let publisherTime = articleData["publisher_time"].int {
            self.publisherTime = publisherTime
        }
        if let status = articleData["status"].bool {
            self.status = status
        }
        if let image = articleData["image"].string {
            self.image = image
        }
        if let link = articleData["link"].string {
            self.link = link
        }
        if let updatedAt = articleData["updated_at"].int {
            self.updatedAt = updatedAt
        }
        if let video = articleData["video"].string {
            self.video = video
        }
        if let categoryId = articleData["category_id"].int {
            self.categoryId = categoryId
        }
    }

}
