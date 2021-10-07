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
    
    enum CodingKeys: String, CodingKey {
        case id
        case ownerID = "owner_id"
        case sizes
    }
}

class Size: Codable {
    var type: String = ""
    var url: String = ""
}
