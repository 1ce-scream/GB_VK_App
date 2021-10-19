//
//  Photo.swift
//  VKApp_TalalayVV
//
//  Created by Vitaliy Talalay on 07.10.2021.
//

import Foundation
import RealmSwift

class Photo: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var ownerID: Int = 0
    var sizes = List<Size>()
    var likes: Likes? = nil
    
    enum CodingKeys: String, CodingKey {
        case id
        case ownerID = "owner_id"
        case sizes, likes
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    override static func indexedProperties() -> [String] {
        return ["ownerID"]
    }
}

class Likes: Object, Codable {
    @objc dynamic var userLikes: Int = 0
    @objc dynamic var count: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case count
    }
}

class Size: Object, Codable {
    @objc dynamic var type: String = ""
    @objc dynamic var url: String = ""
    
    enum CodingKeys: String, CodingKey {
        case type
        case url
    }
}
