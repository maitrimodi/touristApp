//
//  AttractionViewController.swift
//  TouristApp
//
//  Created by Nevil Sheta on 03/04/21.
//

import UIKit

class AttractionViewController: UIViewController {
    
    let defaults = UserDefaults.standard

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "ATTRACTIONS"
        let logButton : UIBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItem.Style.plain, target: self, action: #selector(gotSettingPage))
        
        self.navigationItem.rightBarButtonItem = logButton
    }
    
    
    @objc func gotSettingPage(){
        self.navigationController?.popViewController(animated: true)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        defaults.setValue(false, forKey: "rememberMeState")
    }
}

