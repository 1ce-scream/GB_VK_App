//
//  LikeControl.swift
//  VKApp_TalalayVV
//
//  Created by Vitaliy Talalay on 01.09.2021.
//

import UIKit

class LikeControl: UIControl {
    
    let networkService = NetworkService()
    var ownerId = 0
    var itemId = 0
    var imageView = UIImageView()
    var isLike = false
    
    // MARK: Private properties
    
    private var likeCountLabel = UILabel()
    
    private var likeCounter = 0
    
    // MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
    
    // MARK: Private methods
    
    private func setupView() {
        // Добавляем изображение в subview
        self.addSubview(imageView)
        // Добавляем действие при нажатии на изображение
        self.addTarget(self, action: #selector(tapControl), for: .touchUpInside)
        // Устанавливаем цвет изображения
        imageView.tintColor = .systemRed
        // Выбираем изображение сердца из системных изображений
        imageView.image = UIImage(systemName: "heart")
        // Добавляем отображение лейбла по умолчанию(до первого нажатия)
        setLikeCounterLabel()
    }
    
    private func setLikeCounterLabel(){
        // Добавляем лейбл в subview
        addSubview(likeCountLabel)
        // Присваиваем переменной значение счетчика и приводим к типу string
        let likeString = String(self.likeCounter)
        // Присваиваем значение лейблу с простенькой анимацией
        UIView.transition(with: likeCountLabel,
                          duration: 0.3,
                          options: .transitionFlipFromTop,
                          animations: { [unowned self] in
                            self.likeCountLabel.text = String(likeString)
                          })
        
        // Устанавливаем цвет текста
        likeCountLabel.textColor = .systemRed
//        likeCountLabel.backgroundColor = .systemBackground
        // Отключаем autoresize
        likeCountLabel.translatesAutoresizingMaskIntoConstraints = false
        // Привязка к изображению
        likeCountLabel.trailingAnchor.constraint(
            equalTo: imageView.leadingAnchor,
            constant: -8).isActive = true
        // Привязка к центру по оси Y
        likeCountLabel.centerYAnchor.constraint(
            equalTo: imageView.centerYAnchor).isActive = true
    }
    
    // MARK: Methods
    
    func setLike(count: Int){
        likeCounter = count
        setLikeCounterLabel()
    }
    
    // MARK: Actions
    
    // Метод для переключения состояний изображения и счетчика
    @objc func tapControl(){
        isLike.toggle()
        // Проверяем флаг переключения и изменяем состояния в зависимости от флага
        if isLike {
            imageView.image = UIImage(systemName: "heart.fill")
            likeCounter += 1
            setLikeCounterLabel()
            networkService.addLike(type: "photo", ownerId: ownerId, itemId: itemId)
        } else {
            imageView.image = UIImage(systemName: "heart")
            likeCounter -= 1
            setLikeCounterLabel()
            networkService.deleteLike(type: "photo", ownerId: ownerId, itemId: itemId)
        }
    }
}
