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
                !self.isCancelled,
                error == nil,
                let responseData = responseData
            else { return }
            
            self.data = responseData
            self.state = .finished
        }
        .resume()
    }
}
