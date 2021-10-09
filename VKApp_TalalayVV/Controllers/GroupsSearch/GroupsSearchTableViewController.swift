//
//  GroupsSearchTableViewController.swift
//  VKApp_TalalayVV
//
//  Created by Виталий Талалай on 24.08.2021.
//

import UIKit

class GroupsSearchTableViewController: UITableViewController {
    
    // Массив имитирующий список групп пользователя
//    var someGroups = [
//        Group(id: 4444, name: "Group 4", logo: UIImage(named: "group4")),
//        Group(id: 5555, name: "Group 5", logo: UIImage(named: "group5")),
//        Group(id: 6666, name: "Group 6", logo: UIImage(named: "group6"))
//    ]
    
    private let networkService = NetworkService()
    var communities = [Community]()
    var didSelectIndexCommunity: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkService.getSearchCommunity(text: "Привидения", onComplete: { [weak self] (communities) in
                    self?.communities = communities
                    self?.tableView.reloadData()
                })
    }

    // MARK: - Table view data source

    // Метод задающий количество секций в таблице
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // Метод задающий количество строк в секции
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
        
        communities.count
    }


    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Получаем ячейку из пула и проверяем, что ячейка нужного типа
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "groupSearchCells",
            for: indexPath) as? GroupsSearchCell
        else { return UITableViewCell() }
        
        // Присваиваем данные каждой строке
        cell.configure(group: communities[indexPath.row])

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

}
