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
}
