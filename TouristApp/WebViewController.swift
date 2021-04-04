//
//  WebViewController.swift
//  TouristApp
//
//  Created by maitri Modi on 2021-04-04.
//

import UIKit
import WebKit
class WebViewController: UIViewController , WKNavigationDelegate {

    @IBOutlet weak var webOutlet: WKWebView!
    var website = ""
    override func loadView() {
        webOutlet = WKWebView()
        webOutlet.navigationDelegate = self
        view = webOutlet
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: website)!
        webOutlet.load(URLRequest(url: url))
        webOutlet.allowsBackForwardNavigationGestures = true
        // Do any additional setup after loading the view.
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
