//
//  FriendsCollectionViewController.swift
//  VKApp_TalalayVV
//
//  Created by Виталий Талалай on 24.08.2021.
//

import UIKit
import RealmSwift
import Nuke

class FriendsCollectionViewController: UICollectionViewController {
    // MARK: - Properties
    
    /// Массив с фотографиями друга
    private var photos = [Photo]()
    /// ID друга
    var userID: Int?
    /// Токен уведомлений
    private var notificationToken: NotificationToken?
    /// Сетевые сервисы
    private let networkService = NetworkService()
   
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        collectionView.reloadData()
    }
    
    // MARK: - Methods
    
    /// Метод загрузки фото
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
        
        let index = collectionView.indexPathsForSelectedItems?.first
        friendPVC.selectedPhoto = index!.last!
        
    }
    
    // MARK: - UICollectionViewDataSource
    
    override func numberOfSections(
        in collectionView: UICollectionView) -> Int {
            return 1
        }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
            photos.count
        }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            guard
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: "friendsCollectionCell",
                    for: indexPath) as? FriendsCollectionCell
            else { return UICollectionViewCell() }
            
            let urlString = photos[indexPath.item].sizes.last?.url
            
            if let url = URL(string: urlString ?? "") {
                Nuke.loadImage(with: url, into: cell.friendImageView)
            }
            
            let isLiked = photos[indexPath.item].isLiked
            if isLiked {
                cell.likeControl.isLike = true
                cell.likeControl.imageView.image = UIImage(systemName: "heart.fill")
            } else {
                cell.likeControl.isLike = false
                cell.likeControl.imageView.image = UIImage(systemName: "heart")
            }
            cell.likeControl.setLike(count: photos[indexPath.item].likesCount)
            cell.likeControl.ownerId = photos[indexPath.item].ownerID
            cell.likeControl.itemId = photos[indexPath.item].id
            return cell
        }
}
