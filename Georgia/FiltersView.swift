//
//  FiltersView.swift
//  Georgia
//
//  Created by MOZI Development on 10/12/15.
//  Copyright (c) 2015 MOZI Development. All rights reserved.
//

import UIKit

class FiltersView: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Filters"
        var backButton = UIBarButtonItem(image: UIImage(named: "filters_close_button@3x.png"), style: .Plain, target: self, action: "closeView")
        self.navigationItem.rightBarButtonItem = backButton
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.barTintColor = UIColor.darkGrayColor()
    }
    
    func closeView() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
  }
