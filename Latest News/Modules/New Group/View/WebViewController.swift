//
//  WebViewController.swift
//  Latest News
//
//  Created by Soha Ahmed Hamdy on 31/07/2023.
//

import UIKit
import WebKit
import Lottie

class WebViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet weak var noData: LottieAnimationView!
    @IBOutlet weak var webView: WKWebView!
    var link : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        if let url = URL(string: link ?? ""){
            let request = URLRequest(url: url)
            webView.load(request)
            noData.isHidden = true
            webView.isHidden = false
        }
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        webView.isHidden = true
        noData.isHidden = false
        noData.contentMode = .scaleAspectFit
        noData.loopMode = .loop
        noData.play()
        print("failed to load")
    }
}
