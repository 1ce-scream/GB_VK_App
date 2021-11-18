//
//  News.swift
//  VKApp_TalalayVV
//
//  Created by Vitaliy Talalay on 06.09.2021.
//

import UIKit

class NewsModel: Codable {
    let postID: Int
    let text: String
    let date: Double
    let attachments: [Attachment]?
    let likes: LikeModel
    let sourceID: Int
    let views: ViewsModel
    var avatarURL: String?
    var creatorName: String?
    var photosURL: [String]? {
        get {
            let photosURL = attachments?.compactMap{ $0.photo?.sizes?.last?.url }
            return photosURL
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case postID = "post_id"
        case text
        case date
        case likes
        case attachments
        case sourceID = "source_id"
        case avatarURL
        case views
        case creatorName
    }
    
    func getStringDate() -> String {
        let dateFormatter = DateFormatterVK()
        return dateFormatter.convertDate(timeIntervalSince1970: date)
    }
}

class Attachment: Codable {
    let type: String?
    let photo: PhotoNews?
}

class LikeModel: Codable {
    let count: Int
    let userLike: Int
    
    enum CodingKeys: String, CodingKey {
        case count
        case userLike = "user_likes"
    }
}

class ViewsModel: Codable {
    let count: Int
}

class PhotoNews: Codable {
    let id: Int?
    let ownerID: Int?
    let sizes: [SizeNews]?

    enum CodingKeys: String, CodingKey {
        case id
        case ownerID = "owner_id"
        case sizes
    }
}

class SizeNews: Codable {
    let type: String?
    let url: String?
}
