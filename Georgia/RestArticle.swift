//
//  RestArticle.swift
//  Georgia
//
//  Created by MOZI Development on 10/28/15.
//  Copyright (c) 2015 MOZI Development. All rights reserved.
//

import Foundation

class RestArticle {
    
    let dataManager = DataManager()
    
    var articleId: Int? = nil
    var articleIsDeleted: Int? = nil
    var createdAt: Int? = nil
    var image: String? = nil
    var link: String? = nil
    var publisherTime: Int? = nil
    var status: Int? = nil
    var text: String? = nil
    var title: String? = nil
    var updatedAt: Int? = nil
    var video: String? = nil
    var category: Category? = nil
    var publisher: Publisher? = nil
    
    init(articleData: NSDictionary) {
        if let id = articleData["id"] as? Int {
            self.articleId = id
            self.text = self.dataManager.getText(id)
        }
        if let isDeleted = articleData["is_deleted"] as? Int {
            self.articleIsDeleted = isDeleted
        }
        if let createdAt = articleData["created_at"] as? Int {
            self.createdAt = createdAt
        }
        if let title = articleData["title"] as? String {
            self.title = title
        }
        if let publisherId = articleData["publisher_id"] as? Int {
            self.dataManager.getPublishers(publisherId, completionHandler: {(publisherForArticle: Publisher) -> Void in
                self.publisher = publisherForArticle
            })
        }
        if let publisherTime = articleData["publisher_time"] as? Int {
            self.publisherTime = publisherTime
        }
        if let status = articleData["status"] as? Int {
            self.status = status
        }
        if let image = articleData["image"] as? String {
            self.image = image
        }
        if let link = articleData["link"] as? String {
            self.link = link
        }
        if let updatedAt = articleData["updated_at"] as? Int {
            self.updatedAt = updatedAt
        }
        if let video = articleData["video"] as? String {
            self.video = video
        }
        if let categoryId = articleData["category_id"] as? Int {
            self.dataManager.getCategories(categoryId, completionHandler: {(categoryForArticle: Category) -> Void in
                self.category = categoryForArticle
            })
        }
    }

}