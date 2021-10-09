//
//  Group.swift
//  VKApp_TalalayVV
//
//  Created by Виталий Талалай on 24.08.2021.
//

import UIKit

struct Group: Equatable {
    var id: Int
    var name: String
    var logo: UIImage?
}

/// Codable модель группы
class Community: Codable, Equatable {
    static func == (lhs: Community, rhs: Community) -> Bool {
        if lhs.id == rhs.id {
            return true
        } else {
            return false
        }
    }
    
    var id: Int = 0
    var name: String = ""
    var avatarURL: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case avatarURL = "photo_100"
    }
}
