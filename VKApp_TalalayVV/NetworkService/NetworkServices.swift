//
//  NetworkServices.swift
//  VKApp_TalalayVV
//
//  Created by Vitaliy Talalay on 03.10.2021.
//

import UIKit

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
    func getFriends(onComplete: @escaping ([Friend]) -> Void) {
        urlConstructor.path = "/method/friends.get"
        
        urlConstructor.queryItems = [
            URLQueryItem(name: "order", value: "name"),
            URLQueryItem(name: "fields", value: "photo_100"),
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
            
            guard let friends = try? JSONDecoder().decode(
                Response<Friend>.self,
                from: responseData).response.items
            else { return }
            DispatchQueue.main.async {
                onComplete(friends)
            }
        }
        task.resume()
    }
    
    //MARK: - Photo
    func getPhoto(for ownerID: Int?, onComplete: @escaping ([Photo]) -> Void) {
        
        
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
            
            guard let photos = try? JSONDecoder().decode(
                Response<Photo>.self,
                from: responseData).response.items
            else { return }
            DispatchQueue.main.async {
                onComplete(photos)
            }
        }
        task.resume()
    }
    
    //MARK: - User Communities
    func getCommunities(onComplete: @escaping ([Community]) -> Void)  {
        urlConstructor.path = "/method/groups.get"
        
        urlConstructor.queryItems = [
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "fields", value: "photo_100"),
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
            
            guard let communities = try? JSONDecoder().decode(
                Response<Community>.self,
                from: responseData).response.items
            else { return }
            
            DispatchQueue.main.async {
                onComplete(communities)
            }
        }
        task.resume()
    }
    
    func leaveCommunity(id: Int, onComplete: @escaping (Int) -> Void) {
        urlConstructor.path = "/method/groups.leave"
        
        urlConstructor.queryItems = [
            URLQueryItem(name: "group_id", value: String(id)),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: constants.versionAPI),
        ]
        let task = session.dataTask(with: urlConstructor.url!) {
            (data, response, error) in
            
            guard
                let data = data
            else { return }
            guard
                let response = try? JSONDecoder().decode(
                    ResponseJoin.self,
                    from: data)
            else { return }
            
            DispatchQueue.main.async {
                onComplete(response.response)
            }
        }
        task.resume()
    }
    
    func joinCommunity(id: Int, onComplete: @escaping (Int) -> Void) {
        urlConstructor.path = "/method/groups.join"
        
        urlConstructor.queryItems = [
            URLQueryItem(name: "group_id", value: String(id)),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: constants.versionAPI),
        ]
        let task = session.dataTask(with: urlConstructor.url!) {
            (data, response, error) in
            
            guard
                let data = data
            else { return }
            
            guard
                let response = try? JSONDecoder().decode(
                    ResponseJoin.self,
                    from: data)
            else { return }
            
            DispatchQueue.main.async {
                onComplete(response.response)
            }
        }
        task.resume()
    }
    
    func getSearchCommunity(text: String?, onComplete: @escaping ([Community]) -> Void) {
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
            
            guard
                let communities = try? JSONDecoder().decode(Response<Community>.self, from: responseData).response.items
            else { return }
            DispatchQueue.main.async {
                onComplete(communities)
            }
        }
        task.resume()
    }

private var images = [String: UIImage]()
    
private func loadPhoto(atIndexpath indexPath: IndexPath, byUrl url: String) {
        
        guard let urlRequest = URL(string: url) else { return }
        let request = URLRequest(url: urlRequest)
        URLSession.shared.dataTask(with: request) { (data, response, _ ) in
            guard
                let data = data,
                let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.images[url] = image
            }
        }.resume()
        
    }
    
func photo(atIndexpath indexPath: IndexPath, byUrl url: String) -> UIImage? {
        var image: UIImage?
        if let photo = images[url] {
            image = photo
        } else {
            loadPhoto(atIndexpath: indexPath, byUrl: url)
        }
        return image
    }
}
