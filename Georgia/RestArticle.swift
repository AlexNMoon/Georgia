//
//  RestArticle.swift
//  Georgia
//
//  Created by MOZI Development on 10/28/15.
//  Copyright (c) 2015 MOZI Development. All rights reserved.
//

import Foundation

class RestArticle {
    
    let articleId: Int!
    let articleIsDeleted: Int!
    let createdAt: Int!
    let image: String!
    let link: String!
    let publisherTime: Int!
    let status: Int!
    let text: String!
    let title: String!
    let updatedAt: Int!
    let video: String!
    let category: Category!
    let publisher: Publisher!
    
    init(articleData: NSDictionary) {
        if let id = articleData["id"] as? Int {
            self.articleId = id
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
    }

}