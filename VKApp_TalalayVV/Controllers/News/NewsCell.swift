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
    
    func configure(news: NewsModel) {
    //        avatarImageView.image = news.avatar
            self.avatarImageView.loadImage(by: news.avatarURL ?? "")
            self.creatorNameTextLabel.text = news.creatorName
            self.newsTextLabel.text = news.text
    //        photoView.setImages(photos: news.photos)
            self.viewsCount.text = "Просмотров: " + String(news.views.count)
            self.likeControl.setLike(count: news.likes.count)
        }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
