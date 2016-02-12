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
        var encodedString = ""
        let encodedData = data.dataUsingEncoding(NSUTF8StringEncoding)!
        let attributedOptions : [String: AnyObject] = [
            NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
            NSCharacterEncodingDocumentAttribute: NSUTF8StringEncoding
        ]
        do {
            let attributedString = try NSAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil)
            encodedString = attributedString.string
        } catch {
            fatalError("Unhandled error: \(error)")
        }
        return encodedString
    }
    
}