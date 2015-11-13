//
//  RestPablisher.swift
//  Georgia
//
//  Created by MOZI Development on 10/28/15.
//  Copyright (c) 2015 MOZI Development. All rights reserved.
//

import Foundation
import SwiftyJSON

class RestPublisher {
    
    let stringEncoding = StringEncoding()
    
    let address: String?
    let createdAt: Int?
    let email: String?
    let logo: String?
    let name: String?
    let publDescription: String?
    let publisherId: Int?
    let publIsDeleted: Int?
    let site: String?
    let telephone: String?
    let updatedAt: Int?
    
    init(publisherData: JSON) {
        if let address = publisherData["address"].string {
            self.address = self.stringEncoding.encoding(address)
        } else {
            self.address = nil
        }
        if let description = publisherData["description"].string {
            self.publDescription = self.stringEncoding.encoding(description)
        } else {
            self.publDescription = nil
        }
        if let email = publisherData["email"].string {
            self.email = email
        } else {
            self.email = nil
        }
        if let id = publisherData["id"].int {
            self.publisherId = id
        } else {
            self.publisherId = nil
        }
        if let isDeleted = publisherData["is_deleted"].int{
            self.publIsDeleted = isDeleted
        } else {
            self.publIsDeleted = nil
        }
        if let logo = publisherData["logo"].string {
            self.logo = logo
        } else {
            self.logo = nil
        }
        if let phone = publisherData["phone"].string {
            self.telephone = phone
        } else {
            self.telephone = nil
        }
        if let name = publisherData["publisher_name"].string {
            self.name = self.stringEncoding.encoding(name)
        } else {
            self.name = nil
        }
        if let site = publisherData["site"].string {
            self.site = site
        } else {
            self.site = nil
        }
        if let createdAt = publisherData["created_at"].int {
            self.createdAt = createdAt
        } else {
            self.createdAt = nil
        }
        if let updatedAt = publisherData["updated_at"].int {
            self.updatedAt = updatedAt
        } else {
            self.updatedAt = nil
        }
    }
    
}