//
//  NetworkServices.swift
//  VKApp_TalalayVV
//
//  Created by Vitaliy Talalay on 03.10.2021.
//

import Foundation

class NetworkService {
    
    private var urlConstructor = URLComponents()
    private let constants = NetworkConstants()
    private let configuration: URLSessionConfiguration!
    private let session: URLSession!
    
    init(){
        urlConstructor.scheme = constants.scheme
        urlConstructor.host = constants.host
        configuration = URLSessionConfiguration.default
        session = URLSession(configuration: configuration)
    }
    
    //MARK: - User Friends
    func getFriends() {
        urlConstructor.path = "/method/friends.get"
        
        urlConstructor.queryItems = [
            URLQueryItem(name: "order", value: "name"),
            URLQueryItem(name: "fields",
                         value: """
                         sex,
                         bdate,
                         city,
                         country,
                         photo_100,
                         photo_200_orig
                         """),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: constants.versionAPI),
        ]
        
        let task = session.dataTask(with: urlConstructor.url!) {
            (responseData, urlResponse, error) in
            
            if let response = urlResponse as? HTTPURLResponse {
                print(response.statusCode)
            }
            
            guard
                error == nil,
                let responseData = responseData
            else { return }
            
            let json = try? JSONSerialization.jsonObject(
                with: responseData,
                options: .fragmentsAllowed)
            DispatchQueue.main.async {
                print(json!)
            }
        }
        task.resume()
    }
    
    //MARK: - Photo
    func getPhoto(for ownerID: Int?) {
        
        
        urlConstructor.path = "/method/photos.getAll"
        
        guard let owner = ownerID else { return }
        
        urlConstructor.queryItems = [
            URLQueryItem(name: "owner_id", value: String(owner)),
            URLQueryItem(name: "photo_sizes", value: "1"),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "count", value: "20"),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: constants.versionAPI),
        ]
        
        let task = session.dataTask(with: urlConstructor.url!) {
            (responseData, urlResponse, error) in
            
            if let response = urlResponse as? HTTPURLResponse {
                print(response.statusCode)
            }
            
            guard
                error == nil,
                let responseData = responseData
            else { return }
            
            let json = try? JSONSerialization.jsonObject(
                with: responseData,
                options: .fragmentsAllowed)
            DispatchQueue.main.async {
                print(json!)
            }
        }
        task.resume()
    }
    
    //MARK: - User Communities
    func getCommunities() {
        urlConstructor.path = "/method/groups.get"
        
        urlConstructor.queryItems = [
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "fields", value: "description"),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: constants.versionAPI),
        ]
        let task = session.dataTask(with: urlConstructor.url!) {
            (responseData, urlResponse, error) in
            
            if let response = urlResponse as? HTTPURLResponse {
                print(response.statusCode)
            }
            
            guard
                error == nil,
                let responseData = responseData
            else { return }
            
            let json = try? JSONSerialization.jsonObject(
                with: responseData,
                options: .fragmentsAllowed)
            DispatchQueue.main.async {
                print(json!)
            }
        }
        task.resume()
    }
    
    func getSearchCommunity(text: String?) {
        urlConstructor.path = "/method/groups.search"
        
        urlConstructor.queryItems = [
            URLQueryItem(name: "q", value: text),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: constants.versionAPI),
        ]
        
        let task = session.dataTask(with: urlConstructor.url!) {
            (responseData, urlResponse, error) in
            
            if let response = urlResponse as? HTTPURLResponse {
                print(response.statusCode)
            }
            
            guard
                error == nil,
                let responseData = responseData
            else { return }
            
            let json = try? JSONSerialization.jsonObject(
                with: responseData,
                options: .fragmentsAllowed)
            DispatchQueue.main.async {
                print(json!)
            }
        }
        task.resume()
    }
}
