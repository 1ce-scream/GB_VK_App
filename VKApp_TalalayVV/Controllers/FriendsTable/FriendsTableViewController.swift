//
//  FriendsTableViewController.swift
//  VKApp_TalalayVV
//
//  Created by Виталий Талалай on 16.08.2021.
//

import UIKit

class FriendsTableViewController: UITableViewController {

    // Массив имитирующий список друзей
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
//        self.tableView.register(
//            FriendsCell.self,
//            forCellReuseIdentifier: "friendsCells")
//        //второй вариант
//        tableView.register(
//            FriendsCell.self,
//            forCellReuseIdentifier: "friendsCells")
    }

    // MARK: - Table view data source

    // Метод задающий количество секций в таблице
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // Метод задающий количество строк в секции таблицы
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
        
        // Задается количество строк равное длине массива друзей
        friends.count
    }

    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Получаем ячейку из пула и проверяем, что ячейка нужного типа
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "friendsCells",
            for: indexPath) as? FriendsCell
        // Иначе возвращаем пустую ячейку
        else { return UITableViewCell() }

        //Присваиваем данные каждой строке
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
            // Метод для снятия выделения с ячейки
            tableView.deselectRow(at: indexPath, animated: true)
        }

    }
    
    // Передаем данные в коллекцию при переходе
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Проверяем в нужный ли контроллер осуществляется переход
        guard let friendCVC = segue.destination
                as? FriendsCollectionViewController
        else { return }
        
        // Получаем индекс выделенной ячейки
        if let index = tableView.indexPathForSelectedRow {
            // Получаем данные друга из выделенной ячейки
            let selectedFriend = friends[index.row]
            // Передаем нужные данные
            friendCVC.friendPhotos.append(selectedFriend.avatar!)
        }
    }

}
