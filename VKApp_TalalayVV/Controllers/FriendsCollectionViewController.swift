//
//  FriendsCollectionViewController.swift
//  VKApp_TalalayVV
//
//  Created by Виталий Талалай on 24.08.2021.
//

import UIKit
import RealmSwift


class FriendsCollectionViewController: UICollectionViewController {
    // MARK: - Properties
    
    /// Массив с фотографиями друга
    private var photos = [Photo]()
    /// ID друга
    var userID: Int?
    private var notificationToken: NotificationToken?
    private let networkService = NetworkService()
   
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
//        collectionView.reloadData()
    }
    
    // MARK: - Methods
    
    func loadData() {
        networkService.getPhoto(for: userID)
        
        let tmpPhoto = try? RealmService.load(typeOf: Photo.self)
        notificationToken = tmpPhoto?.observe(on: .main)
        { [weak self] realmChange in
            
            switch realmChange {
            case .initial(let objects):
                self?.photos = Array(objects).filter {
                    $0.ownerID == self!.userID }
                self?.collectionView.reloadData()
            case .update(let objects, _, _, _):
                self?.photos = Array(objects).filter {
                    $0.ownerID == self!.userID }
            case .error(let error):
                print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
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
//            cell.configure(photo: photos[indexPath.item].sizes.last!.url)
           
            
            guard let photoURL = photos[indexPath.item].sizes.last?.url
            else { return cell }
            cell.friendImageView.image = networkService.photo(
                atIndexpath: indexPath,
                byUrl: photoURL)

////            guard let isLiked = photos[indexPath.item].likes?.userLikes
////            else { return cell }
//            
//            if isLiked == 1 {
//                cell.likeControl.isLike = true
//                cell.likeControl.imageView.image = UIImage(systemName: "heart.fill")
//            } else {
//                cell.likeControl.isLike = false
//                cell.likeControl.imageView.image = UIImage(systemName: "heart")
//            }
//            cell.likeControl.setLike(count: photos[indexPath.item].likes!.count)
//            cell.likeControl.ownerId = photos[indexPath.item].ownerID
//            cell.likeControl.itemId = photos[indexPath.item].id
            return cell
        }
    
//    override func collectionView(
//        _ collectionView: UICollectionView,
//        didSelectItemAt indexPath: IndexPath) {
//
//            let photoView = PhotoViewController()
//            photoView.photos = photos
//            photoView.selectedPhoto = indexPath.item
//            photoView.modalPresentationStyle = .automatic
//            photoView.modalTransitionStyle = .coverVertical
//            navigationController?.pushViewController(photoView, animated: true)
//        }
    // MARK: UICollectionViewDelegate
    
}

