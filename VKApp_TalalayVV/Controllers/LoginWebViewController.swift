//
//  LoginWebViewController.swift
//  VKApp_TalalayVV
//
//  Created by Vitaliy Talalay on 01.10.2021.
//

import UIKit
import WebKit

class LoginWebViewController: UIViewController {
    
    @IBOutlet weak var loginWebView: WKWebView!
    
    private var urlComponents: URLComponents = {
        var urlComp = URLComponents()
        urlComp.scheme = "https"
        urlComp.host = "oauth.vk.com"
        urlComp.path = "/authorize"
        urlComp.queryItems = [
            URLQueryItem(name: "client_id", value: "7965024"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "336918"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.130")
        ]
        return urlComp
    }()
    
    private lazy var request = URLRequest(url: urlComponents.url!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginWebView.load(request)
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
