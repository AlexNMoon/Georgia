//
//  StringEncoding.swift
//  Georgia
//
//  Created by MOZI Development on 10/28/15.
//  Copyright (c) 2015 MOZI Development. All rights reserved.
//

import Foundation

class StringEncoding {
    
    func encoding(data: String) -> String {
        return (try! NSAttributedString(data: data.dataUsingEncoding(NSUTF8StringEncoding)!, options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,NSCharacterEncodingDocumentAttribute:NSUTF8StringEncoding], documentAttributes: nil)).string
    }
    
   /* func htmlEncoding(data: String) -> String {
        return (try! )
    }*/
}