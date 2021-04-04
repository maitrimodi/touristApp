//
//  AttractionDetailsViewController.swift
//  TouristApp
//
//  Created by maitri Modi on 2021-04-04.
//

import UIKit
//import WebKit
class AttractionDetailsViewController: UIViewController{
//    override func loadView() {
//                webView = WKWebView()
//                webView.navigationDelegate = self
//                view = webView
//            }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        nameLabel.text = attraction.name
        addressLabel.text = attraction.address
        image2Outlet.image = UIImage(named: attraction.photos[1])
        image3Outlet.image = UIImage(named: attraction.photos[2])
        image4Outlet.image = UIImage(named: attraction.photos[3])
        websiteLabel.setTitle(attraction.website, for: .normal)
        phoneNoLabel.setTitle(attraction.phoneNo, for: .normal)
        pricingLabel.text = "$ \(attraction.pricing)"
        descriptionLabel.text = attraction.description
        
    
        
        // Do any additional setup after loading the view.
    }
    // MARK: - Outlet
//    var webView: WKWebView!
    var attraction: AttractionList!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var image2Outlet: UIImageView!
    @IBOutlet weak var image3Outlet: UIImageView!
    @IBOutlet weak var image4Outlet: UIImageView!
    
    
   
    
    @IBOutlet weak var phoneNoLabel: UIButton!
    @IBOutlet weak var websiteLabel: UIButton!
        
        @IBAction func websiteButtonPressed(_ sender: Any) {
//            let url = URL(string: attraction.website)!
//            webView.load(URLRequest(url: url))
//            webView.allowsBackForwardNavigationGestures = true
            guard let pass = storyboard?.instantiateViewController(identifier: "webViewController") as? WebViewController else {
                                    print("Cannot find the pass view controller")
                                    return
                                }
            pass.website = attraction.website
                                show(pass, sender: self)
        }
        
        @IBOutlet weak var descriptionLabel: UILabel!
        @IBOutlet weak var pricingLabel: UILabel!
        
    @IBAction func phoneButtonPressed(_ sender: Any) {
        if let url = URL(string: "tel://\(attraction.phoneNo)"),
        UIApplication.shared.canOpenURL(url) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
            print("Phone no pressed")
    }
    
    
    /*
     
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    }
}
