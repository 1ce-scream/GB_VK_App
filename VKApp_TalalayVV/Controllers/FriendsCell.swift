//
//  FriendsTableViewCell.swift
//  VKApp_TalalayVV
//
//  Created by Виталий Талалай on 24.08.2021.
//

import UIKit

class FriendsCell: UITableViewCell {

    // Связываем элементы ячейки с контроллером ячейки
    @IBOutlet weak var friendAvatarImageView: UIImageView!
    @IBOutlet weak var friendNameLabel: UILabel!
   
    // Задаем конфигурацию ячейки
    func configure(user: User) {
        friendAvatarImageView.image = user.avatar
        friendNameLabel.text = user.name
    }
}
