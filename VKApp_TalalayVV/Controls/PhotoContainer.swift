//
//  PhotoContainer.swift
//  VKApp_TalalayVV
//
//  Created by Vitaliy Talalay on 07.09.2021.
//

import UIKit

class  PhotoView: UIView {
    
    // MARK: Private properties
    
    // Инициализируем imageViews
    private var collageView1 = UIImageView()
    private var collageView2 = UIImageView()
    private var collageView3 = UIImageView()
    private var collageView4 = UIImageView()
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setImages()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setImages()
    }
    
    // MARK: Methods
    func loadImages(photosUrl: [String]) -> [UIImage?] {
        var photos: [UIImage?] = [UIImage(named: "Concert 3"),]
        photosUrl.forEach { index in
            let data = try? Data(contentsOf: URL(string: index)!)
            let image = UIImage(data: data!)
            photos.append(image)
        }
        return photos
    }
    /// Метод устанавливающий фото в контейнер исходя из их колличества
    func setImages(photos: [UIImage?] = []){
        // Проверяем не пуст ли массив с фото
        guard !photos.isEmpty else { return }
        
        // Присваиваем значения и задаем параметры imageViews
        // в зависимости от колличества фото
        switch photos.count {
        case 1:
            // Добавляем imageView в subview
            addSubview(collageView1)
            // Отключаем авторесайз
            collageView1.translatesAutoresizingMaskIntoConstraints = false
            collageView1.contentMode = UIView.ContentMode.scaleAspectFill
            // Присваиваем значение
            collageView1.image = photos[0]
            // Задаем констрейнты
            NSLayoutConstraint.activate([
                collageView1.topAnchor.constraint(
                    equalTo: topAnchor),
                collageView1.leadingAnchor.constraint(
                    equalTo: leadingAnchor),
                collageView1.trailingAnchor.constraint(
                    equalTo: trailingAnchor),
                collageView1.bottomAnchor.constraint(
                    equalTo: bottomAnchor)
            ])
        case 2:
            // Добавляем imageViews в subview
            addSubview(collageView1)
            addSubview(collageView2)
            // Отключаем авторесайз
            collageView1.translatesAutoresizingMaskIntoConstraints = false
            collageView2.translatesAutoresizingMaskIntoConstraints = false
            // Присваиваем значения
            collageView1.image = photos[0]
            collageView2.image = photos[1]
            // Задаем contentMode для избежания искажения фото
            collageView1.contentMode = UIView.ContentMode.scaleAspectFit
            collageView2.contentMode = UIView.ContentMode.scaleAspectFit
            // Задаем констрейнты
            NSLayoutConstraint.activate([
                collageView1.topAnchor.constraint(
                    equalTo: topAnchor),
                collageView1.leadingAnchor.constraint(
                    equalTo: leadingAnchor),
                collageView1.widthAnchor.constraint(
                    equalTo: collageView2.widthAnchor),
                collageView1.bottomAnchor.constraint(
                    equalTo: bottomAnchor),
                
                collageView2.topAnchor.constraint(
                    equalTo: topAnchor),
                collageView2.leadingAnchor.constraint(
                    equalTo: collageView1.trailingAnchor),
                collageView2.trailingAnchor.constraint(
                    equalTo: trailingAnchor),
                collageView2.bottomAnchor.constraint(
                    equalTo: bottomAnchor),
            ])
        case 3:
            // Добавляем imageViews в subview
            addSubview(collageView1)
            addSubview(collageView2)
            addSubview(collageView3)
            // Отключаем авторесайз
            collageView1.translatesAutoresizingMaskIntoConstraints = false
            collageView2.translatesAutoresizingMaskIntoConstraints = false
            collageView3.translatesAutoresizingMaskIntoConstraints = false
            // Присваиваем значения
            collageView1.image = photos[0]
            collageView2.image = photos[1]
            collageView3.image = photos[2]
            // Задаем contentMode для избежания искажения фото
            collageView1.contentMode = UIView.ContentMode.scaleAspectFill
            // Задаем констрейнты
            NSLayoutConstraint.activate([
                collageView1.topAnchor.constraint(
                    equalTo: topAnchor),
                collageView1.leadingAnchor.constraint(
                    equalTo: leadingAnchor),
                collageView1.widthAnchor.constraint(
                    equalTo: collageView2.widthAnchor),
                collageView1.heightAnchor.constraint(
                    equalTo: collageView1.widthAnchor),
                collageView1.bottomAnchor.constraint(
                    equalTo: bottomAnchor),
                
                collageView2.topAnchor.constraint(
                    equalTo: topAnchor),
                collageView2.leadingAnchor.constraint(
                    equalTo: collageView1.trailingAnchor),
                collageView2.trailingAnchor.constraint(
                    equalTo: trailingAnchor),
                collageView2.heightAnchor.constraint(
                    equalTo: collageView3.heightAnchor),
                
                collageView3.topAnchor.constraint(
                    equalTo: collageView2.bottomAnchor),
                collageView3.leadingAnchor.constraint(
                    equalTo: collageView1.trailingAnchor),
                collageView3.trailingAnchor.constraint(
                    equalTo: trailingAnchor),
                collageView3.widthAnchor.constraint(
                    equalTo: collageView1.widthAnchor),
                collageView3.bottomAnchor.constraint(
                    equalTo: bottomAnchor)
            ])
        case 4...:
            // Добавляем imageViews в subview
            addSubview(collageView1)
            addSubview(collageView2)
            addSubview(collageView3)
            addSubview(collageView4)
            // Отключаем авторесайз
            collageView1.translatesAutoresizingMaskIntoConstraints = false
            collageView2.translatesAutoresizingMaskIntoConstraints = false
            collageView3.translatesAutoresizingMaskIntoConstraints = false
            collageView4.translatesAutoresizingMaskIntoConstraints = false
            // Присваиваем значения
            collageView1.image = photos[0]
            collageView2.image = photos[1]
            collageView3.image = photos[2]
            collageView4.image = photos[3]
            // Задаем констрейнты
            NSLayoutConstraint.activate([
                collageView1.topAnchor.constraint(
                    equalTo: topAnchor),
                collageView1.leadingAnchor.constraint(
                    equalTo: leadingAnchor),
                collageView1.widthAnchor.constraint(
                    equalTo: collageView2.widthAnchor),
                collageView1.heightAnchor.constraint(
                    equalTo: collageView1.widthAnchor),
                
                collageView2.topAnchor.constraint(
                    equalTo: topAnchor),
                collageView2.leadingAnchor.constraint(
                    equalTo: collageView1.trailingAnchor),
                collageView2.trailingAnchor.constraint(
                    equalTo: trailingAnchor),
                collageView2.heightAnchor.constraint(
                    equalTo: collageView1.heightAnchor),
                
                
                collageView3.topAnchor.constraint(
                    equalTo: collageView1.bottomAnchor),
                collageView3.leadingAnchor.constraint(
                    equalTo: leadingAnchor),
                collageView3.widthAnchor.constraint(
                    equalTo: collageView1.widthAnchor),
                collageView3.heightAnchor.constraint(
                    equalTo: collageView1.widthAnchor),
                collageView3.bottomAnchor.constraint(
                    equalTo: bottomAnchor),
                
                collageView4.topAnchor.constraint(
                    equalTo: collageView2.bottomAnchor),
                collageView4.leadingAnchor.constraint(
                    equalTo: collageView3.trailingAnchor),
                collageView4.trailingAnchor.constraint(
                    equalTo: trailingAnchor),
                collageView3.heightAnchor.constraint(
                    equalTo: collageView1.widthAnchor),
                collageView4.bottomAnchor.constraint(
                    equalTo: bottomAnchor),
                
            ])
        default:
            print("Smth went wrong")
        }
    }
}
