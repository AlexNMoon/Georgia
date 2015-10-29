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
    
    let articleId: Int?
    let articleIsDeleted: Int?
    let createdAt: Int?
    let image: String?
    let link: String?
    let publisherTime: Int?
    let status: Int?
    let text: String?
    let title: String?
    let updatedAt: Int?
    let video: String?
    //let category: RestCategory?
    //let publisher: RestPublisher?
    
    init(articleData: NSDictionary) {
        if let id = articleData["id"] as? Int {
            self.articleId = id
            self.text = self.dataManager.getText(id)
        } else {
            self.articleId = nil
        }
        if let isDeleted = articleData["is_deleted"] as? Int {
            self.articleIsDeleted = isDeleted
        } else {
            self.articleIsDeleted = nil
        }
        if let createdAt = articleData["created_at"] as? Int {
            self.createdAt = createdAt
        } else {
            self.createdAt = nil
        }
        if let title = articleData["title"] as? String {
            self.title = title
        } else {
            self.title = nil
        }
        if let publisherId = articleData["publisher_id"] as? Int {
            //self.publisher = nil
        }
        if let publisherTime = articleData["publisher_time"] as? Int {
            self.publisherTime = publisherTime
        } else {
            self.publisherTime = nil
        }
        if let status = articleData["status"] as? Int {
            self.status = status
        } else {
            self.status = nil
        }
        if let image = articleData["image"] as? String {
            self.image = image
        } else {
            self.image = nil
        }
        if let link = articleData["link"] as? String {
            self.link = link
        } else {
            self.link = nil
        }
        if let updatedAt = articleData["updated_at"] as? Int {
            self.updatedAt = updatedAt
        } else {
            self.updatedAt = nil
        }
        if let video = articleData["video"] as? String {
            self.video = video
        } else {
            self.video = nil
        }
        
       // self.category = nil
        
    }

}