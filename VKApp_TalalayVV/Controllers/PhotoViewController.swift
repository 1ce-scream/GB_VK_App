//
//  PhotoViewController.swift
//  VKApp_TalalayVV
//
//  Created by Vitaliy Talalay on 13.09.2021.
//


import UIKit

class PhotoViewController: UIViewController {
    // MARK: - Рroperties
    
    /// Массив с фото
    var photos = [UIImage]()
    
    // MARK: - Private properties
    
    /// Индекс выбранного фото
    private var selectedPhoto = 0
    /// Фото в левой стороне экрана
    private var leftImageView: UIImageView!
    /// Фото по центру экрана
    private var middleImageView: UIImageView!
    /// Фото в правой стороне экрана
    private var rightImageView: UIImageView!
    /// PropertyAnimator для свайпа вправо
    private var swipeToRight: UIViewPropertyAnimator!
    /// PropertyAnimator для свайпа влево
    private var swipeToLeft: UIViewPropertyAnimator!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /// Распознаватель жестов для анимации
        let gestPan = UIPanGestureRecognizer(
            target: self,
            action: #selector(onPan(_:)))
        view.addGestureRecognizer(gestPan)
//        setImage()
        startAnimate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Убираем вьюхи с фото перед исчезновение контроллера
        view.subviews.forEach({ $0.removeFromSuperview() })
    }
    
    // MARK: - Private methods
    
    /// Метод задающий вьюхи и устанавливающий фото в них
    private func setImage(){
        /// Индекс левого фото
        var indexPhotoLeft = selectedPhoto - 1
        /// Индекс центрального фото
        let indexPhotoMid = selectedPhoto
        /// Индекс правого фото
        var indexPhotoRight = selectedPhoto + 1
        
        if indexPhotoLeft < 0 {
            indexPhotoLeft = photos.count - 1
        }
        
        if indexPhotoRight > photos.count - 1 {
            indexPhotoRight = 0
        }
        
        // Убираем вьюхи с фото, чтоб не накапливались при анимации
        view.subviews.forEach({ $0.removeFromSuperview() })
        
        leftImageView = UIImageView()
        middleImageView = UIImageView()
        rightImageView = UIImageView()
        
        // Добавляем вьюхи с фото
        view.addSubview(leftImageView)
        view.addSubview(middleImageView)
        view.addSubview(rightImageView)
        
        // Задаем контент мод
        leftImageView.contentMode = .scaleAspectFit
        middleImageView.contentMode = .scaleAspectFit
        rightImageView.contentMode = .scaleAspectFit
        
        // Отключаем авторесайз
        leftImageView.translatesAutoresizingMaskIntoConstraints = false
        middleImageView.translatesAutoresizingMaskIntoConstraints = false
        rightImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Добавляем констрейнты
        NSLayoutConstraint.activate([
            middleImageView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 30),
            middleImageView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -30),
            middleImageView.heightAnchor.constraint(
                equalTo: middleImageView.widthAnchor),
            middleImageView.centerYAnchor.constraint(
                equalTo: view.centerYAnchor),
            
            leftImageView.trailingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 10),
            leftImageView.centerYAnchor.constraint(
                equalTo: view.centerYAnchor),
            leftImageView.heightAnchor.constraint(
                equalTo: middleImageView.heightAnchor),
            leftImageView.widthAnchor.constraint(
                equalTo: middleImageView.widthAnchor),
            
            rightImageView.leadingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -10),
            rightImageView.centerYAnchor.constraint(
                equalTo: view.centerYAnchor),
            rightImageView.heightAnchor.constraint(
                equalTo: middleImageView.heightAnchor),
            rightImageView.widthAnchor.constraint(
                equalTo: middleImageView.widthAnchor),
        ])
        
        // Присваиваем фото из массива по индексу
        middleImageView.image = photos[indexPhotoMid]
        leftImageView.image = photos[indexPhotoLeft]
        rightImageView.image = photos[indexPhotoRight]
        
        /// Размер вьюхи для дальнейшей анимации увеличения
        let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
        self.middleImageView.transform = scale
        self.rightImageView.transform = scale
        self.leftImageView.transform = scale
        
    }
    
    /// Метод анимации при появлении фото
    private func startAnimate(){
        setImage()
        UIView.animate(
            withDuration: 1,
            delay: 0,
            options: [],
            animations: {
                self.middleImageView.transform = .identity
                self.rightImageView.transform = .identity
                self.leftImageView.transform = .identity
            })
    }
    
    // MARK: - Actions
    
    @objc func onPan(_ recognizer: UIPanGestureRecognizer){
        switch recognizer.state {
        case .began:
            swipeToRight = UIViewPropertyAnimator(
                duration: 0.5,
                curve: .easeInOut,
                animations: {
                    UIView.animate(
                        withDuration: 0.1,
                        delay: 0,
                        options: [],
                        animations: {
                            /// Размер вьюхи для анимации уменьшения
                            let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
                            /// Перемещение вьюхи
                            let translation = CGAffineTransform(
                                translationX: self.view.bounds.maxX - 40,
                                y: 0)
                            /// Изменение вьюхи состоящее из размера и перемещения
                            let transform = scale.concatenating(translation)
                            self.middleImageView.transform = transform
                            self.rightImageView.transform = transform
                            self.leftImageView.transform = transform
                        }, completion: { _ in
                            // Изменяем индекс фото с проверкой
                            // для избежания выхода за пределы массива
                            self.selectedPhoto -= 1
                            if self.selectedPhoto < 0 {
                                self.selectedPhoto = self.photos.count - 1
                            }
                            self.startAnimate()
                        })
                })
            swipeToLeft = UIViewPropertyAnimator(
                duration: 0.5,
                curve: .easeInOut,
                animations: {
                    UIView.animate(
                        withDuration: 0.1,
                        delay: 0,
                        options: [],
                        animations: {
                            /// Размер вьюхи для анимации уменьшения
                            let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
                            /// Перемещение вьюхи
                            let translation = CGAffineTransform(
                                translationX: -self.view.bounds.maxX + 40,
                                y: 0)
                            /// Изменение вьюхи состоящее из размера и перемещения
                            let transform = scale.concatenating(translation)
                            self.middleImageView.transform = transform
                            self.rightImageView.transform = transform
                            self.leftImageView.transform = transform
                        }, completion: { _ in
                            // Изменяем индекс фото с проверкой
                            // для избежания выхода за пределы массива
                            self.selectedPhoto += 1
                            if self.selectedPhoto > self.photos.count - 1 {
                                self.selectedPhoto = 0
                            }
                            self.startAnimate()
                        })
                })
        case .changed:
            let translationX = recognizer.translation(in: self.view).x
            if translationX > 0 {
                swipeToRight.fractionComplete = abs(translationX)/100
            } else {
                swipeToLeft.fractionComplete = abs(translationX)/100
            }
            
        case .ended:
            swipeToRight.continueAnimation(
                withTimingParameters: nil,
                durationFactor: 0)
            swipeToLeft.continueAnimation(
                withTimingParameters: nil,
                durationFactor: 0)
        default:
            return
        }
    }
}
