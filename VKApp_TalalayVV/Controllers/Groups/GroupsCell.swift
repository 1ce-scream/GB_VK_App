//
//  GroupsCell.swift
//  VKApp_TalalayVV
//
//  Created by Виталий Талалай on 24.08.2021.
//

import UIKit

class GroupsCell: UITableViewCell {
    
    // Связываем элементы ячейки с контроллером ячейки
    @IBOutlet weak var groupLogoImageView: AvatarImage!
    @IBOutlet weak var groupNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Инициализируем распознаватель жестов
        let tap = UITapGestureRecognizer()
        // Добавляем действие при нажатии
        tap.addTarget(self, action: #selector(tapOnGroupLogo(_:)))
        // Добавляем распознаватель жестов к лого
        groupLogoImageView.addGestureRecognizer(tap)
        // Разрешаем взаимодействие
        groupLogoImageView.isUserInteractionEnabled = true
    }
    
    // Задаем конфигурацию ячейки
    func configure(group: Community) {
        let url = URL(string: group.avatarURL)
        let data = try? Data(contentsOf: url!)
        groupLogoImageView.image = UIImage(data: data!)
        groupNameLabel.text = group.name
    }
    
    @objc func tapOnGroupLogo(_ tapGestureRecognizer: UITapGestureRecognizer) {
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            options: [],
            animations: {
                let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
                self.groupLogoImageView.transform = scale
            }) { _ in
                UIView.animate(
                    withDuration: 0.3,
                    delay: 0,
                    usingSpringWithDamping: 0.3,
                    initialSpringVelocity: 1.0,
                    options: [],
                    animations: {
                        self.groupLogoImageView.transform = .identity
                    })
            }
    }
}
