//
//  Group.swift
//  VKApp_TalalayVV
//
//  Created by Виталий Талалай on 24.08.2021.
//

import UIKit
import RealmSwift

struct Group: Equatable {
    var id: Int
    var name: String
    var logo: UIImage?
}

/// Codable модель группы
class Community: Object, Codable {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var avatarURL: String = ""
    
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case avatarURL = "photo_100"
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    override static func indexedProperties() -> [String] {
        return ["name"]
    }
}
