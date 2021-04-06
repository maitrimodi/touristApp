//
//  AttractionDetailsViewController.swift
//  TouristApp
//
//  Created by maitri Modi on 2021-04-04.
//

import UIKit

//import WebKit
class AttractionDetailsViewController: UIViewController{
    let defaults = UserDefaults.standard
    var attraction: AttractionList!
    
    // MARK: - Outlet
    @IBOutlet weak var rateSlider: UISlider?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var image2Outlet: UIImageView!
    @IBOutlet weak var image3Outlet: UIImageView!
    @IBOutlet weak var image4Outlet: UIImageView!
    @IBOutlet weak var sliderValueLabel: UILabel!
    @IBOutlet weak var phoneNoLabel: UIButton!
    @IBOutlet weak var websiteLabel: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var pricingLabel: UILabel!
    @IBOutlet weak var wishBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = attraction.name
        
        // On navBar display logout button
        let logButton : UIBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItem.Style.plain, target: self, action: #selector(gotSettingPage))
        self.navigationItem.rightBarButtonItem = logButton
        
        // On navBar display back button
        let backButton : UIBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(goBackToAttractionList))
        self.navigationItem.leftBarButtonItem = backButton
        
        //Display values appropriately for attraction selected
        nameLabel.text = attraction.name
        addressLabel.text = attraction.address
        image2Outlet.image = UIImage(named: attraction.photos[1])
        image3Outlet.image = UIImage(named: attraction.photos[2])
        image4Outlet.image = UIImage(named: attraction.photos[3])
        websiteLabel.setTitle(attraction.website, for: .normal)
        phoneNoLabel.setTitle(attraction.phoneNo, for: .normal)
        pricingLabel.text = "$ \(attraction.pricing)"
        descriptionLabel.text = attraction.description
        let username = defaults.string(forKey: "userName")!
    
        //Check for wishlisted item previously and display accordingly
        let getWishListData = defaults.array(forKey: "\(username)_wishids") as? [Int]
        if(getWishListData == nil){
            wishBtn.setImage(UIImage(named: "wishlist-empty"), for: .normal)
        }else{
            for favlist in getWishListData!{
                print("\(favlist) == \(attraction.id)")
                if(favlist == attraction.id){    //if selected is wishlist
                    wishBtn.setImage(UIImage(named: "wishlist"), for: .normal)
                }
                
            }
        }
        
        //Check for ratings provided previously and display accordingly
        let previousData = defaults.dictionary(forKey: "\(username)_rating")
        if(previousData != nil){
            if let entry = previousData!.keys.first(where: { $0.lowercased().contains("\(attraction.id)") }) {
                rateSlider?.setValue((previousData!["\(entry)"]! as! Float), animated: true)
                sliderValueLabel.text = "\(previousData!["\(entry)"]!)"
            }
        }
    }
    
    // When ever rating slider value is changed set and display the rating respectively
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        sliderValueLabel.text = "\(Int(sender.value))"
        let username = defaults.string(forKey: "userName")!
        var previousData = defaults.dictionary(forKey: "\(username)_rating")
        if(previousData != nil){
            if let entry = previousData!.keys.first(where: { $0.lowercased().contains("\(attraction.id)") }) {
                //rewrite existing data
                previousData!["\(entry)"] = Int(sender.value)
                defaults.set(previousData, forKey: "\(username)_rating")
            }else{
                previousData!["\(attraction.id)"] = Int(sender.value)
                defaults.set(previousData!, forKey: "\(username)_rating")
            }
        }else{
            //entering new or rated first time
            previousData = ["\(attraction.id)": Int(sender.value)]
            defaults.set(previousData!, forKey: "\(username)_rating")
        }
        
    }
    
    //Website clicked and navigated to the browser
    @IBAction func websiteButtonPressed(_ sender: Any) {
        guard let pass = storyboard?.instantiateViewController(identifier: "webViewController") as? WebViewController else {
            print("Cannot find the pass view controller")
            return
        }
        pass.website = attraction.website
        show(pass, sender: self)
    }
    
    
    //Navigate to dialer
    @IBAction func phoneButtonPressed(_ sender: Any) {
        if let url = URL(string: "tel://\(attraction.phoneNo)"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            print("Phone no pressed")
        }
    }
    
    //When ever place needs to be select/deselect as wishlist click on heart icon
    @IBAction func wishBtnClick(_ sender: Any) {
        let username = defaults.string(forKey: "userName")!
        if self.wishBtn.currentImage === UIImage(named: "wishlist") {
            //remove from wishlist
            wishBtn.setImage(UIImage(named: "wishlist-empty"), for: .normal)
            
            var modify = defaults.array(forKey: "\(username)_wishids") as! [Int]
            if(modify.contains(attraction.id)){
                modify = modify.filter { $0 != attraction.id }
            }
            //setting removed data
            defaults.set(modify, forKey: "\(username)_wishids")
        }else{
            //add to wishlist
            wishBtn.setImage(UIImage(named: "wishlist"), for: .normal)
            var previousData:[Int]?
            let getNewId:Int = attraction.id
            if let getPreviousData = defaults.array(forKey: "\(username)_wishids") {
                //already exist
                previousData = getPreviousData as? [Int]
                var insert : Bool = false
                for checkSame in previousData!{
                    if(checkSame == getNewId){
                        let temp = defaults.array(forKey: "\(username)_wishids")
                        insert = true
                        break;
                    }
                }
                if(insert == false){
                    previousData?.append(getNewId)
                    defaults.set(previousData, forKey: "\(username)_wishids")
                    let temp = defaults.array(forKey: "\(username)_wishids")
                    print(temp!)
                }
            }else{
                print("Setting for first time")
                let newData:[Int] = [getNewId]
                defaults.set(newData, forKey: "\(username)_wishids")
            }
        }
    }
    
    //On click of logout button deselect rememberMe option
    @objc func gotSettingPage(){
        defaults.setValue(false, forKey: "rememberMeState")
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "loginPage") as? LoginViewController
        navigationController?.setNavigationBarHidden(true, animated: true)
        tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    //On click of back button deselect rememberMe option
    @objc func goBackToAttractionList()
    {
        defaults.setValue(false, forKey: "rememberMeState")
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
}
