//
//  FriendsTableViewCell.swift
//  VKApp_TalalayVV
//
//  Created by Виталий Талалай on 24.08.2021.
//

import UIKit

class FriendsCell: UITableViewCell {
    
    @IBOutlet weak var friendAvatarImageView: AvatarImage!
    @IBOutlet weak var friendNameLabel: UILabel!
    @IBOutlet weak var avatarBackgroundView: AvatarBackgroundShadowView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(tapOnAvatar(_:)))
        friendAvatarImageView.addGestureRecognizer(tap)
        friendAvatarImageView.isUserInteractionEnabled = true
    }
    
    /// Метод конфигурации ячейки
    func configure(user: Friend) {
        let url = URL(string: user.avatarURL)
        let data = try? Data(contentsOf: url!)
        friendAvatarImageView.image = UIImage(data: data!)
        friendNameLabel.text = user.firstName + " " + user.lastName
    }
    
    /// Действие  при нажатии на аватарку
    @objc func tapOnAvatar(_ tapGestureRecognizer: UITapGestureRecognizer) {
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            options: [],
            animations: {
                let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
                self.friendAvatarImageView.transform = scale
                self.avatarBackgroundView.transform = scale
            }) { _ in
                UIView.animate(
                    withDuration: 0.3,
                    delay: 0,
                    usingSpringWithDamping: 0.3,
                    initialSpringVelocity: 1.0,
                    options: [],
                    animations: {
                        self.friendAvatarImageView.transform = .identity
                        self.avatarBackgroundView.transform = .identity
                    })
            }
    }
}
