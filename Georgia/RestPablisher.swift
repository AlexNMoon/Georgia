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
    
    init(publisherData: AnyObject) {
        if let address = publisherData["address"] {
            self.address = self.stringEncoding.encoding(address)
        } else {
            self.address = nil
        }
        if let description = publisherData["description"] as? String {
            self.publDescription = self.stringEncoding.encoding(description)
        } else {
            self.publDescription = nil
        }
        if let email = publisherData["email"] as? String {
            self.email = email
        } else {
            self.email = nil
        }
        if let id = publisherData["id"] as? Int {
            self.publisherId = id
        } else {
            self.publisherId = nil
        }
        if let isDeleted = publisherData["is_deleted"] as? Int{
            self.publIsDeleted = isDeleted
        } else {
            self.publIsDeleted = nil
        }
        if let logo = publisherData["logo"] as? String {
            self.logo = logo
        } else {
            self.logo = nil
        }
        if let phone = publisherData["phone"] as? String {
            self.telephone = phone
        } else {
            self.telephone = nil
        }
        if let name = publisherData["publisher_name"] as? String {
            self.name = self.stringEncoding.encoding(name)
        } else {
            self.name = nil
        }
        if let site = publisherData["site"] as? String {
            self.site = site
        } else {
            self.site = nil
        }
        if let createdAt = publisherData["created_at"] as? Int {
            self.createdAt = createdAt
        } else {
            self.createdAt = nil
        }
        if let updatedAt = publisherData["updated_at"] as? Int {
            self.updatedAt = updatedAt
        } else {
            self.updatedAt = nil
        }
    }
    
}