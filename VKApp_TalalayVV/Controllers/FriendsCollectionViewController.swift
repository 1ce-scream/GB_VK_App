//
//  FriendsCollectionViewController.swift
//  VKApp_TalalayVV
//
//  Created by Виталий Талалай on 24.08.2021.
//

import UIKit


class FriendsCollectionViewController: UICollectionViewController {
    
//    var friend: [String] = []
    var friendPhotos: [UIImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()

//       self.collectionView!.register(FriendsCollectionCell.self, forCellWithReuseIdentifier: "friendsCollectionCell")

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    //метод задающий количество секций коллекции
    override func numberOfSections(
        in collectionView: UICollectionView) -> Int {
        return 1
    }

    //метод задающий количество айтемов коллекции
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
        friendPhotos.count
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //получение ячейки из пула и проверка на соответствие ячейки необходимому типу
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "friendsCollectionCell",
                for: indexPath) as? FriendsCollectionCell
        else { return UICollectionViewCell() }
        
        cell.configure(photo: friendPhotos[indexPath.item])
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
