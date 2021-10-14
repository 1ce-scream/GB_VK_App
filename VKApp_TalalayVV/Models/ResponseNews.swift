//
//  ResponseNews.swift
//  VKApp_TalalayVV
//
//  Created by Vitaliy Talalay on 14.10.2021.
//

import Foundation

class ResponseNews: Codable {
    let response: ItemsNews
}

class ItemsNews: Codable {
    let items: [NewsModel]
    let profiles: [ProfileNews]
    let groups: [GroupNews]
    let nextFrom: String
    
    enum CodingKeys: String, CodingKey {
        case items
        case profiles
        case groups
        case nextFrom = "next_from"
    }
}

class ProfileNews: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let avatarURL: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case avatarURL = "photo_100"
    }
}

class GroupNews: Codable {
    let id: Int
    let name: String
    let avatarURL: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case avatarURL = "photo_100"
    }
}
