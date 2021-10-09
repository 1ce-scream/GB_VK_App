//
//  GroupsSearchTableViewController.swift
//  VKApp_TalalayVV
//
//  Created by Виталий Талалай on 24.08.2021.
//

import UIKit

class GroupsSearchTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    // Массив имитирующий список групп пользователя
    
    private let networkService = NetworkService()
    
    var communities = [Community]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        networkService.getSearchCommunity(
            text: "",
            onComplete: { [weak self] (communities) in
                self?.communities = communities
                self?.tableView.reloadData()
            })
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        networkService.getSearchCommunity(
            text: searchText,
            onComplete: { [weak self] (communities) in
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
