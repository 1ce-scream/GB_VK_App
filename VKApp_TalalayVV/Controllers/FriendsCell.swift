//
//  FriendsTableViewCell.swift
//  VKApp_TalalayVV
//
//  Created by Виталий Талалай on 24.08.2021.
//

import UIKit

class FriendsCell: UITableViewCell {

    // Связываем элементы ячейки с контроллером ячейки
    @IBOutlet weak var friendAvatarImageView: AvatarImage!
    @IBOutlet weak var friendNameLabel: UILabel!
    @IBOutlet weak var avatarBackgroundView: AvatarBackgroundShadowView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Инициализируем распознаватель жестов
        let tap = UITapGestureRecognizer()
        // Добавляем действие при нажатии
        tap.addTarget(self, action: #selector(tapOnAvatar(_:)))
        // Добавляем распознаватель жестов к аватарке
        friendAvatarImageView.addGestureRecognizer(tap)
        // Разрешаем взаимодействие
        friendAvatarImageView.isUserInteractionEnabled = true
    }
    
    /// Метод конфигурации ячейки
    func configure(user: User) {
        friendAvatarImageView.image = user.avatar
        friendNameLabel.text = user.name
    }

    /// Метод действия при нажатии на аватарку
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
