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
    
    let stringEncoding = StringEncoding()
    
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
    
    init(articleData: JSON) {
        if let id = articleData["id"].int {
            self.articleId = id
            if let textData = self.dataManager.getText(id){
                self.text = self.stringEncoding.encoding(textData["data"]["full_description"].string!)
            }
        }
        if let isDeleted = articleData["is_deleted"].int {
            self.articleIsDeleted = isDeleted
        }
        if let createdAt = articleData["created_at"].int {
            self.createdAt = createdAt
        }
        if let title = articleData["title"].string {
            self.title = title
        }
        if let publisherId = articleData["publisher_id"].int {
            self.dataManager.getPublishers(publisherId, completionHandler: {(publisherForArticle: Publisher) -> Void in
                self.publisher = publisherForArticle
            })
        }
        if let publisherTime = articleData["publisher_time"].int {
            self.publisherTime = publisherTime
        }
        if let status = articleData["status"].int {
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
            self.dataManager.getCategories(categoryId, completionHandler: {(categoryForArticle: Category) -> Void in
                self.category = categoryForArticle
            })
        }
            }

}