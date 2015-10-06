//
//  PublisherView.swift
//  Georgia
//
//  Created by MOZI Development on 10/6/15.
//  Copyright (c) 2015 MOZI Development. All rights reserved.
//

import UIKit

class PublisherView: UIViewController {
    
    let dataManager = DataManager()
    
    @IBOutlet weak var textLable: UILabel!
    
    override func viewDidLoad() {
        dataManager.getText({ (text: String) -> Void in
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.textLable.text = text
            })
            println("text\(text)")
        })
    }

}
