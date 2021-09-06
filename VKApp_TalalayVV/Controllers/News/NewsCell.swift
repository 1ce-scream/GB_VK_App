//
//  NewsCell.swift
//  VKApp_TalalayVV
//
//  Created by Vitaliy Talalay on 06.09.2021.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: AvatarImage!
    @IBOutlet weak var creatorNameTextLabel: UILabel!
    @IBOutlet weak var newsTextLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var viewsCount: UILabel!
    
    func configure(news: News) {
        avatarImageView.image = news.avatar
        creatorNameTextLabel.text = news.creatorName
        newsTextLabel.text = news.newsText
        newsImageView.image = news.photo
        viewsCount.text = "Просмотров: " + String(news.viewsCount)
    }
}
