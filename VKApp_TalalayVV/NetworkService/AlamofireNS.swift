//
//  AlamofireNetworkService.swift
//  VKApp_TalalayVV
//
//  Created by Vitaliy Talalay on 03.10.2021.
//

import Foundation
import Alamofire

final class AlamofireNS {
    
    private let constants = NetworkConstants()
    private var host: String { constants.scheme + "://" + constants.host }
    
    func getFriends() {
        let path = "/method/friends.get"
        let parameters: Parameters = [
            "order": "name",
            "fields": "sex, bdate, city, country, photo_100, photo_200_orig",
            "access_token": Session.shared.token!,
            "v": constants.versionAPI
        ]
        
        AF.request(
            host + path,
            method: .get,
            parameters: parameters)
            .responseJSON { json in
                print(json)
            }
    }
    
    func getPhoto(for ownerID: Int?) {
        guard let owner = ownerID else { return }
        let path = "/method/photos.getAll"
        let parameters: Parameters = [
            "owner_id": String(owner),
            "photo_size": "1",
            "extended": "1",
            "count": "20",
            "access_token": Session.shared.token!,
            "v": constants.versionAPI
        ]
        
        AF.request(
            host + path,
            method: .get,
            parameters: parameters)
            .responseJSON { json in
                print(json)
            }
    }
    
    func getCommunities() {
        let path = "/method/groups.get"
        let parameters: Parameters = [
            "extended": "1",
            "fields": "description",
            "access_token": Session.shared.token!,
            "v": constants.versionAPI
            
        ]
        
        AF.request(
            host + path,
            method: .get,
            parameters: parameters)
            .responseJSON { json in
                print(json)
            }
    }
    
    func getSearchCommunity(text: String?) {
        guard let text = text else { return }
        let path = "/method/groups.search"
        let parameters: Parameters = [
            "q": text,
            "access_token": Session.shared.token!,
            "v": constants.versionAPI
        ]
        
        AF.request(
            host + path,
            method: .get,
            parameters: parameters)
            .responseJSON { json in
                print(json)
            }
    }
}
