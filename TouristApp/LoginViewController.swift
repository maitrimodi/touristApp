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
        let Remail = defaults.string(forKey: "rememberEmail")
        let Rpass = defaults.string(forKey: "rememberPassword")
        userNameLabel.text = Remail
        passwordLabel.text = Rpass
        rememberMe.isOn = false
        super.viewDidLoad()
    }
    
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        let username = userNameLabel.text!
        let password = passwordLabel.text!
        
        for userName in userDetails.keys
        {
            if(userName == username)
            {
                if(userDetails[userName] == password)
                {
                    print("Welcome to tourism app")
                    if(rememberMe.isOn){
                        defaults.set(userNameLabel.text, forKey: "rememberEmail")
                        defaults.set(passwordLabel.text, forKey: "rememberPassword")
                    }
                    defaults.set(userNameLabel.text, forKey: "email")
//                    guard let s2 = storyboard?.instantiateViewController(identifier: "places") as? AttractionViewController else {
//                              return
//                          }
//                    show(s2, sender: self)
                    break;
                }
                else
                {
                    let alertfill = UIAlertController(title: "Please enter valid credentials", message: "", preferredStyle: .alert)
                    self.present(alertfill, animated:true, completion: nil)
                    let fillBtn = UIAlertAction(title: "Ok", style: .destructive, handler: nil)
                    alertfill.addAction(fillBtn)
                }
                
            }
            else{
                let alertfill = UIAlertController(title: "Please enter valid uname", message: "", preferredStyle: .alert)
                self.present(alertfill, animated:true, completion: nil)
                let fillBtn = UIAlertAction(title: "Ok", style: .destructive, handler: nil)
                alertfill.addAction(fillBtn)
            }
        }
        
    }
    
}
