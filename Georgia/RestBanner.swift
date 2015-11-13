//
//  RestBanner.swift
//  Georgia
//
//  Created by MOZI Development on 10/28/15.
//  Copyright (c) 2015 MOZI Development. All rights reserved.
//

import Foundation
import SwiftyJSON

class RestBanner {
    
    let bannerId: Int?
    let image: String?
    let link: String?
    let title: String?
    
    init(bannerData: JSON) {
        if let id = bannerData["id"].int {
            self.bannerId = id
        } else {
           self.bannerId = nil
        }
        if let image = bannerData["image"].string {
            self.image = image
        } else {
            self.image = nil
        }
        if let link = bannerData["link"].string {
            self.link = link
        } else {
            self.link = nil
        }
        if let title = bannerData["title"].string {
            self.title = title
        } else {
            self.title = nil
        }
    }
    
}