//
//  Photo.swift
//  VKApp_TalalayVV
//
//  Created by Vitaliy Talalay on 07.10.2021.
//

import Foundation

class Photo: Codable {
    var id: Int = 0
    var ownerID: Int = 0
    var sizes: [Size] = [Size]()
    var likes: Likes
    
    enum CodingKeys: String, CodingKey {
        case id
        case ownerID = "owner_id"
        case sizes, likes
    }
}

class Likes: Codable {
    var userLikes: Int
    var count: Int
    
    enum CodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case count
    }
}
class Size: Codable {
    var type: String = ""
    var url: String = ""
}
