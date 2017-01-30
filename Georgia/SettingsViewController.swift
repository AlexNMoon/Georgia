//
//  SettingsView.swift
//  Georgia
//
//  Created by MOZI Development on 10/12/15.
//  Copyright (c) 2015 MOZI Development. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        self.navigationItem.title = "About Application"
        let backButton = UIBarButtonItem(image: UIImage(named: "filters_close_button"), style: .plain, target: self, action: #selector(SettingsViewController.closeView))
        self.navigationItem.rightBarButtonItem = backButton
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.barTintColor = UIColor.darkGray
    }
    
    func closeView() {
        self.navigationController?.dismiss(animated: true, completion: {() -> Void in })
    }
    

}
