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
    
    // MARK: -Private methods
    
    /// Метод задания внешнего вида
    private func setupView() {
        self.addSubview(imageView)
        self.addTarget(self, action: #selector(tapControl), for: .touchUpInside)
        imageView.tintColor = .systemRed
        imageView.image = UIImage(systemName: "heart")
        setLikeCounterLabel()
    }
    
    /// Метод для задания колличества лайков
    private func setLikeCounterLabel(){
        addSubview(likeCountLabel)
        let likeString = String(self.likeCounter)
        UIView.transition(with: likeCountLabel,
                          duration: 0.3,
                          options: .transitionFlipFromTop,
                          animations: { [unowned self] in
                            self.likeCountLabel.text = String(likeString)
                          })
        
        likeCountLabel.textColor = .systemRed
        likeCountLabel.translatesAutoresizingMaskIntoConstraints = false
        likeCountLabel.trailingAnchor.constraint(
            equalTo: imageView.leadingAnchor,
            constant: -8).isActive = true
        likeCountLabel.centerYAnchor.constraint(
            equalTo: imageView.centerYAnchor).isActive = true
    }
    
    // MARK: -Methods
    
    func setLike(count: Int){
        likeCounter = count
        setLikeCounterLabel()
    }
    
    // MARK: Actions
    
    /// Метод для переключения состояний изображения и счетчика
    @objc func tapControl(){
        isLike.toggle()
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
