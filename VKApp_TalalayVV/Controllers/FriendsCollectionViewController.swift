//
//  FriendsCollectionViewController.swift
//  VKApp_TalalayVV
//
//  Created by Виталий Талалай on 24.08.2021.
//

import UIKit


class FriendsCollectionViewController: UICollectionViewController {
    
    var friendPhotos: [UIImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Navigation


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
    
//    @IBAction func selectFriend(segue: UIStoryboardSegue) {
//        // Проверяем идентификатор перехода
//        if segue.identifier == "friendsCellSegue" {
//            // Получаем ссылку на контроллер, с которого осуществлен переход
//            guard let selectedFriend = segue.source as?
//                    FriendsTableViewController else { return }
//            // Получаем индекс выделенной ячейки
//            if let indexPath = selectedFriend.tableView.indexPathForSelectedRow {
//                // Получаем данные друга по индексу
//                let selectedFriend = selectedFriend.friends[indexPath.row]
//                // Добавляем фото друга в список
//                friendPhotos.append(selectedFriend.avatar!)
//                // Обновляем коллекцию
//                collectionView.reloadData()
//            }
//        }
//    }

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
