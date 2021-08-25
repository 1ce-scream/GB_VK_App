//
//  FriendsTableViewController.swift
//  VKApp_TalalayVV
//
//  Created by Виталий Талалай on 16.08.2021.
//

import UIKit

class FriendsTableViewController: UITableViewController {

    //массив имитирующий список друзей
    var friends = [
        User(id: 1111, name: "Stan Marsh",
             avatar: UIImage(named: "StanMarsh")),
        User(id: 2222, name: "Kyle Broflovski",
             avatar: UIImage(named: "KyleBroflovski")),
        User(id: 3333, name: "Eric Cartman",
             avatar: UIImage(named: "EricCartman"))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        //регистрация класса кастомной ячейки
//        tableView.register(FriendsCell.self,
//                           forCellReuseIdentifier: "friendsCells")
    }

    // MARK: - Table view data source

    //метод задающий количество секций в таблице
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    //метод задающий количество строк в секции таблицы
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
        
        //задается количество строк равное длине массива друзей
        friends.count
    }

    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //получаем ячейку из пула и проверяем, что ячейка нужного типа
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "friendsCells",
            for: indexPath) as? FriendsCell
        //иначе возвращаем пустую ячейку
        else { return UITableViewCell() }

        //присваиваем данные каждой строке
        cell.configure(user: friends[indexPath.row])
        return cell
    }
    
    // Метод выделения ячейки
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath) {
        
        //defer конструкция которая всегда выполняется в конце кода
        //в независимоти от места ее написания
        defer {
            //метод для снятия выделения с ячейки
            tableView.deselectRow(at: indexPath, animated: true)
        }

    }
    
    //передаем данные в коллекцию при переходе
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //проверяем в нужный ли контроллер осуществляется переход
        guard let friendCVC = segue.destination
                as? FriendsCollectionViewController
        else { return }
        
        //получаем индекс выделенной ячейки
        if let index = tableView.indexPathForSelectedRow {
            //получаем данные друга из выделенной ячейки
            let selectedFriend = friends[index.row]
            //передаем нужные данные
            friendCVC.friendPhotos.append(selectedFriend.avatar!)
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
