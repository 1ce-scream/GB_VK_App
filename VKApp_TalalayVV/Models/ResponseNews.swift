//
//  ResponseNews.swift
//  VKApp_TalalayVV
//
//  Created by Vitaliy Talalay on 14.10.2021.
//

import Foundation

class VKResponse<T:Codable>: Codable {
    let response: ResponseNews<T>
}

class ResponseNews<T: Codable>: Codable {
    let items: [T]
    let profiles: [Friend]?
    let groups: [Community]?
    let nextFrom: String?
    
    enum CodingKeys: String, CodingKey {
        case items
        case profiles
        case groups
        case nextFrom = "next_from"
    }
}
