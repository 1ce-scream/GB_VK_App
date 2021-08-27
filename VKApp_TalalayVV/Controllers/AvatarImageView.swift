//
//  AvatarImageView.swift
//  VKApp_TalalayVV
//
//  Created by Виталий Талалай on 27.08.2021.
//

import UIKit

class AvatarImage: UIImageView {
    // Цвет границы изображения
    @IBInspectable var borderColor: UIColor = .systemBlue
    // Толщина границы изображения
    @IBInspectable var borderWidth: CGFloat = 0.8
    
    override func awakeFromNib() {
        // Радиус закругления углов границы изображения
        self.layer.cornerRadius = self.frame.height / 2
        // Значение, указывающее обрезаны ли подслои по границам слоя
        self.layer.masksToBounds = true
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        // Цвет фона изображения
        self.backgroundColor = .systemBackground
    }
}

class AvatarBackgroundShadowView: UIView {
    // Цвет тени
    @IBInspectable var shadowColor: UIColor = .systemGray
    // Удаленность тени от поля зрения
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 3.0, height: 2.5)
    // Прозрачность тени
    @IBInspectable var shadowOpacity: Float = 0.9
    // Степень размытия тени
    @IBInspectable var shadowRadius: CGFloat = 3.0

    override func awakeFromNib() {
        // Цвет фона View
        self.backgroundColor = .clear
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
    }
}
