//
//  GroupsSearchTableViewController.swift
//  VKApp_TalalayVV
//
//  Created by Виталий Талалай on 24.08.2021.
//

import UIKit

class GroupsSearchTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    /// Массив групп
    var communities = [Community]()
    /// Сетевые сервисы
    private let networkService = NetworkService()
    
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            
            communities.count
        }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "groupSearchCells",
                for: indexPath) as? GroupsSearchCell
            else { return UITableViewCell() }
            
            cell.configure(group: communities[indexPath.row])
            
            return cell
        }
    
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath) {
            
            defer {
                // Метод для снятия выделения с ячейки
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    
}
