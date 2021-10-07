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
    var photos = [Photo]()
    var userID: Int?
    let networkService = NetworkService()
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkService.getPhoto(for: userID, onComplete: { [weak self] (photos) in
            self?.set(photos: photos)
            self?.collectionView.reloadData()
        })
        
    }
    
    // MARK: - Methods
    
    func set(photos: [Photo]) {
        self.photos = photos
    }
    // Передаем данные в фото контроллер при переходе
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Проверяем в нужный ли контроллер осуществляется переход
        guard let friendPVC = segue.destination
                as? PhotoViewController
        else { return }

        friendPVC.photos = photos
        
//        let index = collectionView.indexPathsForSelectedItems?.first
//        friendPVC.selectedPhoto = index!.first!
        
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
            photos.count
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
            //        cell.configure(photo: photos[indexPath.item])
            guard let photoURL = photos[indexPath.item].sizes.last?.url
            else { return cell }
            
            cell.friendImageView.image = networkService.photo(
                atIndexpath: indexPath,
                byUrl: photoURL)
            return cell
        }
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let friendPVC = PhotoViewController()
//        friendPVC.selectedPhoto = indexPath.item
//    }
    // MARK: UICollectionViewDelegate
    
}

