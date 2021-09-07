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
    @IBOutlet weak var viewsCount: UILabel!
    @IBOutlet weak var likeControl: LikeControl!
    @IBOutlet weak var photoView: PhotoView!
    @IBOutlet weak var makeCommentButton: UIButton!
    @IBOutlet weak var repostButton: UIButton!
    
    func configure(news: News) {
        avatarImageView.image = news.avatar
        creatorNameTextLabel.text = news.creatorName
        newsTextLabel.text = news.newsText
        photoView.setImages(photos: news.photos)
        viewsCount.text = "Просмотров: " + String(news.viewsCount)
        self.likeControl.setLike(count: news.likeCount)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
