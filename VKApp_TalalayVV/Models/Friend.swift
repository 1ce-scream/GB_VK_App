//
//  Friend.swift
//  VKApp_TalalayVV
//
//  Created by Vitaliy Talalay on 07.10.2021.
//

import Foundation

class Friend: Codable {
    var id: Int = 0
    var firstName: String = ""
    var lastName: String = ""
    var avatarURL: String = ""
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case avatarURL = "photo_100"
    }
}
