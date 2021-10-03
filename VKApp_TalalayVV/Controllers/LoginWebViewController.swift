//
//  LoginWebViewController.swift
//  VKApp_TalalayVV
//
//  Created by Vitaliy Talalay on 01.10.2021.
//

import UIKit
import WebKit

class LoginWebViewController: UIViewController {
    
    @IBOutlet weak var loginWebView: WKWebView! {
        didSet {
            loginWebView.navigationDelegate = self
        }
    }
    
//    let constants = NetworkConstants()
    
    // Константы для проверки работоспособности запросов
    let smth = NetworkService()
    let alamo = AlamofireNS()
    
    private var urlComponents: URLComponents = {
        var urlComp = URLComponents()
        urlComp.scheme = "https"
        urlComp.host = "oauth.vk.com"
        urlComp.path = "/authorize"
        urlComp.queryItems = [
            URLQueryItem(name: "client_id", value: "7965024"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri",
                         value: "https://oauth.vk.com/blank.html"),
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
}

extension LoginWebViewController: WKNavigationDelegate {
    
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationResponse: WKNavigationResponse,
        decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
            
            guard
                let url = navigationResponse.response.url,
                url.path == "/blank.html",
                let fragment = url.fragment
            else { return  decisionHandler(.allow) }
            
            let parameters = fragment
                .components(separatedBy: "&")
                .map { $0.components(separatedBy: "=") }
                .reduce ([String:String]()) { result, params in
                    var dict = result
                    let key = params[0]
                    let value = params[1]
                    dict[key] = value
                    return dict
                    
                }
            
            guard
                let token = parameters["access_token"],
                let userIDString = parameters["user_id"],
                let userID = Int(userIDString)
            else { return decisionHandler(.allow) }
            
            Session.shared.userID = userID
            Session.shared.token = token
            
            // MARK: - Segue from LoginWebView
            
//            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//            let loginViewController = storyBoard
//                .instantiateViewController(withIdentifier: "LoginViewController")
//            as! LoginViewController
//
//            loginViewController.modalPresentationStyle = .fullScreen
//            self.present(loginViewController, animated: true, completion: nil)
            
            
            // MARK: - Requests checking
            
            print("Token = \(token) and UserID = \(userID)")
            print(Session.shared.token!)
            
//            smth.getFriends()
//            smth.getPhoto(for: Session.shared.userID)
//            smth.getCommunities()
//            smth.getSearchCommunity(text: "Дзен")
//            alamo.getFriends()
//            alamo.getPhoto(for: Session.shared.userID)
//            alamo.getCommunities()
//            alamo.getSearchCommunity(text: "LYPD")
            decisionHandler(.cancel)
        }
}
