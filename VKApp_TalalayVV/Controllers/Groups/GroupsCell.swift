//
//  GroupsCell.swift
//  VKApp_TalalayVV
//
//  Created by Виталий Талалай on 24.08.2021.
//

import UIKit

class GroupsCell: UITableViewCell {

    // Связываем элементы ячейки с контроллером ячейки
    @IBOutlet weak var groupLogoImageView: UIImageView!
    @IBOutlet weak var groupNameLabel: UILabel!
    
    // Задаем конфигурацию ячейки
    func configure(group: Group) {
        groupLogoImageView.image = group.logo
        groupNameLabel.text = group.name
    }

}
