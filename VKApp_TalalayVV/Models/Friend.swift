//
//  Friend.swift
//  VKApp_TalalayVV
//
//  Created by Vitaliy Talalay on 07.10.2021.
//

import Foundation
import RealmSwift

class Friend: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var avatarURL: String = ""
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case avatarURL = "photo_100"
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    override static func indexedProperties() -> [String] {
        return ["firstName", "lastName"]
    }
}
