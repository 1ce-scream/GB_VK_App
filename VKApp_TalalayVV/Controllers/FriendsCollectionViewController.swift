//
//  FriendsCollectionViewController.swift
//  VKApp_TalalayVV
//
//  Created by Виталий Талалай on 24.08.2021.
//

import UIKit


class FriendsCollectionViewController: UICollectionViewController {
    // MARK: - Properties
    
    // Массив имитирующий альбом фотографий друга
    var friendPhotos: [UIImage] = [
        UIImage(named: "South0099")!,
        UIImage(named: "SouthPoster")!,
    ]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Methods
    
    // Передаем данные в фото контроллер при переходе
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Проверяем в нужный ли контроллер осуществляется переход
        guard let friendPVC = segue.destination
                as? PhotoViewController
        else { return }
        
        // Задаем ячейку как отправителя
        let cell: FriendsCollectionCell  = sender as! FriendsCollectionCell
        // Берем фото из ячейки
        let image = cell.friendImageView.image
        // Добавляем фото в массив в PhotoViewController
        friendPVC.photos.append(image!)
        friendPVC.photos.append(friendPhotos[0])
        friendPVC.photos.append(friendPhotos[1])
    }
    
    // MARK: - UICollectionViewDataSource

    // Метод задающий количество секций коллекции
    override func numberOfSections(
        in collectionView: UICollectionView) -> Int {
        return 1
    }

    // Метод задающий количество айтемов коллекции
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
        friendPhotos.count
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Получение ячейки из пула и проверка на соответствие ячейки необходимому типу
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "friendsCollectionCell",
                for: indexPath) as? FriendsCollectionCell
        else { return UICollectionViewCell() }
        
        //Присваиваем данные каждому айтему
        cell.configure(photo: friendPhotos[indexPath.item])
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
}

