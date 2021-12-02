//
//  NetworkServices.swift
//  VKApp_TalalayVV
//
//  Created by Vitaliy Talalay on 03.10.2021.
//

import UIKit
import RealmSwift
import PromiseKit

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
    /// Метод для получения списка друзей пользователя
    func getFriends() {
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
                try? RealmService.save(items: friends)
            }
        }
        task.resume()
    }
    
    //MARK: - Promise Friends request
    func getFriendsPromise() -> Promise<[Friend]> {
        urlConstructor.path = "/method/friends.get"
        
        urlConstructor.queryItems = [
            URLQueryItem(name: "order", value: "name"),
            URLQueryItem(name: "fields", value: "photo_100"),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: constants.versionAPI),
        ]
        
        return Promise { resolver in
            session.dataTask(with: urlConstructor.url!) {
                (responseData, urlResponse, error) in
                
                guard
                    error == nil,
                    let responseData = responseData
                else { return resolver.reject(error!) }
                    
                guard let friends = try? JSONDecoder().decode(
                    Response<Friend>.self,
                    from: responseData).response.items
                else { return resolver.reject(error!) }
                
                resolver.fulfill(friends)
            }.resume()
        }
    }
    //MARK: - Photo
    /// Метод для получения всех фотографий пользователя
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
            
            guard let photos = try? JSONDecoder().decode(
                Response<Photo>.self,
                from: responseData).response.items
            else { return }
            
            photos.forEach {
                $0.likesCount = $0.likes?.count ?? 0
                $0.isLiked = $0.likes?.userLikes ?? 0 > 0
            }
            
            DispatchQueue.main.async {
                try? RealmService.save(items: photos)
            }
        }
        task.resume()
    }
    
    func addLike(type: String, ownerId: Int, itemId: Int) {
        urlConstructor.path = "/method/likes.add"
        urlConstructor.queryItems = [
            URLQueryItem(name: "type", value: type),
            URLQueryItem(name: "owner_id", value: String(ownerId)),
            URLQueryItem(name: "item_id", value: String(itemId)),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: constants.versionAPI),
        ]
        let task = session.dataTask(with: urlConstructor.url!)
        task.resume()
    }
    
    func deleteLike(type: String, ownerId: Int, itemId: Int) {
        urlConstructor.path = "/method/likes.delete"
        urlConstructor.queryItems = [
            URLQueryItem(name: "type", value: type),
            URLQueryItem(name: "owner_id", value: String(ownerId)),
            URLQueryItem(name: "item_id", value: String(itemId)),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: constants.versionAPI),
        ]
        let task = session.dataTask(with: urlConstructor.url!)
        task.resume()
    }
    
    //MARK: - User Communities
    /// Метод для получения групп пользователя
    func getCommunities()  {
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
                try? RealmService.save(items: communities)
            }
        }
        task.resume()
    }
    
    /// Метод для выхода из группы
    func leaveCommunity(id: Int, onComplete: @escaping (Int) -> Void) {
        urlConstructor.path = "/method/groups.leave"
        
        urlConstructor.queryItems = [
            URLQueryItem(name: "group_id", value: String(id)),
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
                let data = responseData
            else { return }
            
            guard
                let response = try? JSONDecoder().decode(
                    ResponseJoin.self,
                    from: data)
            else { return }
            
            let objectsToDelete = try? RealmService.load(typeOf: Community.self)
                .filter("id = %f", id)
            
            guard let item = objectsToDelete else { return }
            try? RealmService.delete(object: item)
            
            DispatchQueue.main.async {
                onComplete(response.response)
            }
        }
        task.resume()
    }
    
    /// Метод для вступления в группу
    func joinCommunity(id: Int, onComplete: @escaping (Int) -> Void) {
        urlConstructor.path = "/method/groups.join"
        
        urlConstructor.queryItems = [
            URLQueryItem(name: "group_id", value: String(id)),
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
                let data = responseData
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
    
    /// Метод для поиска групп
    func getSearchCommunity(text: String?,
                            onComplete: @escaping ([Community])
                            -> Void) {
        
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
                let communities = try? JSONDecoder().decode(
                    Response<Community>.self,
                    from: responseData).response.items
            else { return }
            DispatchQueue.main.async {
                onComplete(communities)
            }
        }
        task.resume()
    }
    
    func getNews(onComplete: @escaping ([NewsModel]) -> Void) {
        
        urlConstructor.path = "/method/newsfeed.get"
        
        urlConstructor.queryItems = [
            URLQueryItem(name: "filters", value: "post"),
            URLQueryItem(name: "start_from", value: "next_from"),
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
                let data = responseData
            else { return }
            
            
//            let json = try? JSONSerialization.jsonObject(
//                with: data,
//                options: .fragmentsAllowed)
            guard
                let news = try? JSONDecoder().decode(
                    Response<NewsModel>.self,
                    from: data).response.items
            else {
                print("News Error")
                return
            }
            
            guard
                let profiles = try? JSONDecoder().decode(
                    ResponseNews.self,
                    from: data).response.profiles
            else {
                print("Profiles error")
                return
            }
            
            guard
                let groups = try? JSONDecoder().decode(
                    ResponseNews.self,
                    from: data).response.groups
            else {
                print("Groups error")
                return
            }
            
            for i in 0..<news.count {
                if news[i].sourceID < 0 {
                    let group = groups.first(
                        where: { $0.id == -news[i].sourceID })
                    news[i].avatarURL = group?.avatarURL
                    news[i].creatorName = group?.name
                } else {
                    let profile = profiles.first(
                        where: { $0.id == news[i].sourceID })
                    news[i].avatarURL = profile?.avatarURL
                    news[i].creatorName = profile?.firstName
                }
            }
            
            DispatchQueue.main.async {
                onComplete(news)
            }
        }
        task.resume()
    }
    // MARK: - Image Services
    
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
