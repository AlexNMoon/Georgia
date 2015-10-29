//
//  RestBanner.swift
//  Georgia
//
//  Created by MOZI Development on 10/28/15.
//  Copyright (c) 2015 MOZI Development. All rights reserved.
//

import Foundation

class RestBanner {
    
    let bannerId: Int?
    let image: String?
    let link: String?
    let title: String?
    
    init(bannerData: NSDictionary) {
        if let id = bannerData["id"] as? Int {
            self.bannerId = id
        } else {
           self.bannerId = nil
        }
        if let image = bannerData["image"] as? String {
            self.image = image
        } else {
            self.image = nil
        }
        if let link = bannerData["link"] as? String {
            self.link = link
        } else {
            self.link = nil
        }
        if let title = bannerData["title"] as? String {
            self.title = title
        } else {
            self.title = nil
        }
    }
    
}