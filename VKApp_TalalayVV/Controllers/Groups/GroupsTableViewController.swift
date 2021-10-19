//
//  GroupsTableViewController.swift
//  VKApp_TalalayVV
//
//  Created by Виталий Талалай on 16.08.2021.
//

import UIKit
import RealmSwift

class GroupsTableViewController: UITableViewController {
    
    @IBOutlet weak var searchNavigationButton: UIBarButtonItem!
    
    /// Сетевые сервисы
    let networkService = NetworkService()
    /// Массив со списоком групп пользователя
    var groups = [Community]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkService.getCommunities(onComplete: { _ in
//            self?.groups = communites
//            self?.tableView.reloadData()
            print("Our Groups WORK!!! ")
        })
        
        loadData()
    }
    
    func loadData() {
        let tmpCommunities = try? RealmService.load(typeOf: Community.self)
        self.groups = Array(tmpCommunities!)
        tableView.reloadData()
    }
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        // Проверяем идентификатор перехода
        if segue.identifier == "addGroupSegue" {
            // Получаем ссылку на контроллер, с которого осуществлен переход
            guard let groupsSearch = segue.source as?
                    GroupsSearchTableViewController else { return }
            // Получаем индекс выделенной ячейки
            if let indexPath = groupsSearch.tableView.indexPathForSelectedRow {
                // Получаем группу по индексу
                let selectedGroup = groupsSearch.communities[indexPath.row]
                // Проверяем на наличие дубликата
                if !groups.contains(selectedGroup) {
                    // Если дубликата нет, отправляем запрос на вступление
                    networkService.joinCommunity(
                        id: selectedGroup.id,
                        onComplete: { [weak self] (value) in
                            
                            guard value == 1 else {
                                print("запрос отклонен")
                                return
                            }
                            
                            self!.groups.append(selectedGroup)
                            // Обновляем таблицу
                            self!.tableView.reloadData()
                        })
                }
            }
        }
    }
    // MARK: - Table view data source
    
    // Метод задающий количество секций в таблице
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    // Метод задающий количество строк в секции
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            
            //Количество строк задается равным длине массива
            groups.count
        }
    
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            // Получаем ячейку из пула и проверяем, что ячейка нужного типа
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "groupsCells",
                for: indexPath) as? GroupsCell
            else { return UITableViewCell() }
            
            // Присваиваем данные каждой строке
            cell.configure(group: groups[indexPath.row])
            
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
    
    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath) {
            
            // Если была нажата кнопка «Удалить»
            if editingStyle == .delete {
                
                let currentGroup = groups[indexPath.row]
                let index = currentGroup.id
                
                networkService.leaveCommunity(
                    id: index,
                    onComplete: { (value) in
                        
                        if value == 1 {
                            print("Вы покинули группу")
                            // Удаляем группу из массива
                            self.groups.remove(at: indexPath.row)
                            // И удаляем строку из таблицы
                            self.tableView.deleteRows(at: [indexPath], with: .fade)
                        } else {
                            print("Ошибка запроса")
                        }
                    })
            }
        }
}
