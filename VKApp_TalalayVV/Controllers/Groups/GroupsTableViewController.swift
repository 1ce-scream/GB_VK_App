//
//  GroupsTableViewController.swift
//  VKApp_TalalayVV
//
//  Created by Виталий Талалай on 16.08.2021.
//

import UIKit

class GroupsTableViewController: UITableViewController {

    @IBOutlet weak var searchNavigationButton: UIBarButtonItem!
    
    // Массив имитирующий список групп
    var groups = [
        Group(id: 1111, name: "Group 1", logo: UIImage(named: "group1")),
        Group(id: 2222, name: "Group 2", logo: UIImage(named: "group2")),
        Group(id: 3333, name: "Group 3", logo: UIImage(named: "group3"))
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    //unwind segue
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        // Проверяем идентификатор перехода
        if segue.identifier == "addGroupSegue" {
            // Получаем ссылку на контроллер, с которого осуществлен переход
            guard let groupsSearch = segue.source as?
                    GroupsSearchTableViewController else { return }
            // Получаем индекс выделенной ячейки
            if let indexPath = groupsSearch.tableView.indexPathForSelectedRow {
                // Получаем группу по индексу
                let selectedGroup = groupsSearch.someGroups[indexPath.row]
                // Проверяем на наличие дубликата
                if !groups.contains(selectedGroup) {
                    // Если дубликата нет, то добавляем группу в список
                    groups.append(selectedGroup)
                    // Обновляем таблицу
                    tableView.reloadData()
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
            // Удаляем группу из массива
                groups.remove(at: indexPath.row)
            // И удаляем строку из таблицы
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
}
