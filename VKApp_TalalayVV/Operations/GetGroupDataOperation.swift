//
//  GetGroupDataOperation.swift
//  VKApp_TalalayVV
//
//  Created by Vitaliy Talalay on 24.11.2021.
//

import Foundation

final class GetGroupDataOperation: AsyncOperation {
    
    var data: Data?
    private let constants = NetworkConstants()
    private let session = URLSession.shared
    private var urlConstructor: URLComponents = {
        var constructor = URLComponents()
        constructor.scheme = "https"
        constructor.host = "api.vk.com"
        return constructor
    }()
    
    override func main() {
        guard
            !isCancelled
        else { return }
        
        urlConstructor.path = "/method/groups.get"
        urlConstructor.queryItems = [
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "fields", value: "photo_100"),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: constants.versionAPI),
        ]
        
        session.dataTask(with: urlConstructor.url!) {
            responseData, urlResponse, error in

            guard
                error == nil,
                let responseData = responseData
            else { return }
            
            self.data = responseData
            self.state = .finished
        }
        .resume()
    }
}

class GetDataOperation: AsyncOperation {
    
    private var urlConstructor = URLComponents()
    private let configuration: URLSessionConfiguration!
    private let session: URLSession!
    private let constants = NetworkConstants()
    private var urlRequest: URL
    private var task: URLSessionTask?
    
    var data: Data?

//    override func cancel() {
//        task?.cancel()
//        super.cancel()
//    }
    
    override func main() {
        
        guard
            !isCancelled
        else { return }
        
        task = session.dataTask(with: urlRequest, completionHandler: {
            (data, response, error) in
            
            guard
                error == nil,
                let data = data
            else { return }
            
            self.data = data
            self.state = .finished
        })
        task?.resume()
    }
    
    init(urlRequest: URL) {
        urlConstructor.scheme = constants.scheme
        urlConstructor.host = constants.host
        configuration = URLSessionConfiguration.default
        session = URLSession(configuration: configuration)
        
        self.urlRequest = urlRequest
    }
    
}

