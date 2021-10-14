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
//    var sizes: [Size] = [Size]()
    var sizes = List<Size>()
    var likes: Likes? = nil
//    var likes = List<Likes>()
    
    enum CodingKeys: String, CodingKey {
        case id
        case ownerID = "owner_id"
        case sizes, likes
    }
    
//    convenience required init(from decoder: Decoder) throws {
//        self.init()
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        self.id = try values.decode(Int.self, forKey: .id)
//        self.ownerID = try values.decode(Int.self, forKey: .ownerID)
//        self.sizes = try values.decode( List<Size>.self, forKey: .sizes)
//        self.likes = try values.decode( Likes.self, forKey: .likes)
//    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class Likes: Object, Codable {
    @objc dynamic var userLikes: Int = 0
    @objc dynamic var count: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case count
    }
    
//    convenience required init(from decoder: Decoder) throws {
//        self.init()
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.userLikes = try container.decode(Int.self, forKey: .userLikes)
//        self.count = try container.decode(Int.self, forKey: .count)
//    }
}

class Size: Object, Codable {
    @objc dynamic var type: String = ""
    @objc dynamic var url: String = ""
}
