//
//  FriendsTableViewCell.swift
//  VKApp_TalalayVV
//
//  Created by Виталий Талалай on 24.08.2021.
//

import UIKit

class FriendsCell: UITableViewCell {

    //связываем элементы ячейки с контроллером ячейки
    @IBOutlet weak var friendAvatarImageView: UIImageView!
    @IBOutlet weak var friendNameLabel: UILabel!
   
    //задаем конфигурацию ячейки
    func configure(user: User) {
        friendAvatarImageView.image = user.avatar
        friendNameLabel.text = user.name
    }
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
