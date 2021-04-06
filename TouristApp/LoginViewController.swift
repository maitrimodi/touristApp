//
//  LoginViewController.swift
//  TouristApp
//
//  Created by Nevil Sheta on 03/04/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    let defaults = UserDefaults.standard
    
    
    @IBOutlet weak var userNameLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    
    @IBOutlet weak var rememberMe: UISwitch!
    
    var userDetails = ["thanos@gmail.com": "5555", "wonderwoman@yahoo.com": "abcd"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "TOURISM APP"
    }
    
    //Validate username & pswd when Login button clicked
    @IBAction func btnClick(_ sender: UIButton) {
        let username = userNameLabel.text!
        let password = passwordLabel.text!
        
        let userNameKeys = userDetails.keys
        if userNameKeys.contains(username)
        {
            let pswd = userDetails[username]
            if pswd == password
            {
                if(rememberMe.isOn){
                    defaults.set(userNameLabel.text, forKey: "rememberEmail")
                    defaults.set(passwordLabel.text, forKey: "rememberPassword")
                    defaults.setValue(rememberMe.isOn, forKey: "rememberMeState")
                }
                else
                {
                    defaults.set("", forKey: "rememberEmail")
                    defaults.set("", forKey: "rememberPassword")
                    defaults.setValue(false, forKey: "rememberMeState")
                }
                defaults.set(userNameLabel.text, forKey: "userName")
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "tabBar") as? UITabBarController
                self.navigationController?.pushViewController(vc!, animated: true)
            }
            else
            {
                let alertfill = UIAlertController(title: "Please enter valid credentials", message: "", preferredStyle: .alert)
                self.present(alertfill, animated:true, completion: nil)
                let fillBtn = UIAlertAction(title: "Ok", style: .destructive, handler: nil)
                alertfill.addAction(fillBtn)
            }
        }
        else
        {
            let alertfill = UIAlertController(title: "Please enter valid uname", message: "", preferredStyle: .alert)
            self.present(alertfill, animated:true, completion: nil)
            let fillBtn = UIAlertAction(title: "Ok", style: .destructive, handler: nil)
            alertfill.addAction(fillBtn)
        }
        
        
    }
    
    //If rememberMe is selected go to AttractionList screen or if logout clicked erase user details
    override func viewWillAppear(_ animated: Bool) {
        
        userNameLabel.text = ""
        passwordLabel.text = ""
        rememberMe.isOn = false
        
        if defaults.bool(forKey: "rememberMeState")
        {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "tabBar") as? UITabBarController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
}
