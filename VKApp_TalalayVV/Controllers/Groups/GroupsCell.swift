//
//  GroupsCell.swift
//  VKApp_TalalayVV
//
//  Created by Виталий Талалай on 24.08.2021.
//

import UIKit

class GroupsCell: UITableViewCell {
    
    @IBOutlet weak var groupLogoImageView: AvatarImage!
    @IBOutlet weak var groupNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(tapOnGroupLogo(_:)))
        groupLogoImageView.addGestureRecognizer(tap)
        groupLogoImageView.isUserInteractionEnabled = true
    }
    
    /// Метод конфигурации ячейки
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
