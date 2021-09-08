//
//  FriendsTableViewController.swift
//  VKApp_TalalayVV
//
//  Created by Виталий Талалай on 16.08.2021.
//

import UIKit

class FriendsViewController: UIViewController, UISearchBarDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    /// Массив имитирующий список друзей
    var friends = [
        User(id: 1111, name: "Stan Marsh",
             avatar: UIImage(named: "StanMarsh")),
        User(id: 1111, name: "Stan Marsh",
             avatar: UIImage(named: "StanMarsh")),
        User(id: 1111, name: "Stan Marsh",
             avatar: UIImage(named: "StanMarsh")),
        User(id: 1111, name: "Stan Marsh",
             avatar: UIImage(named: "StanMarsh")),
        User(id: 1111, name: "Stan Marsh",
             avatar: UIImage(named: "StanMarsh")),
        User(id: 1111, name: "Stan Marsh",
             avatar: UIImage(named: "StanMarsh")),
        User(id: 1111, name: "Stan Marsh",
             avatar: UIImage(named: "StanMarsh")),
        User(id: 1111, name: "Stan Marsh",
             avatar: UIImage(named: "StanMarsh")),
        User(id: 1111, name: "Stan Marsh",
             avatar: UIImage(named: "StanMarsh")),
        User(id: 2222, name: "Kyle Broflovski",
             avatar: UIImage(named: "KyleBroflovski")),
        User(id: 3333, name: "Eric Cartman",
             avatar: UIImage(named: "EricCartman"))
    ]
    
    // MARK: Private properties
    /// Словарь со списком друзей
    private var friendsDict = [Character:[User]]()
    /// Массив первых букв имен друзей
    private var firstLetters: [Character] {
        get {
            friendsDict.keys.sorted()
        }
    }
    /// Контрол по буквам имен
    private var lettersControl: LettersControl?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Присвоение данных таблице
        self.tableView.dataSource = self
        // Присвоение настроек внешнего вида таблицы
        self.tableView.delegate = self
        // Запонение словаря
        self.friendsDict = self.getFriendsDict(searchText: nil, list: friends)
        // Вызов контрола
        setLettersControl()
        // вызов серчбара
        searchBar.delegate = self
        
    }
    
    // MARK: Private methods
    
    /// Метод задающий словарь со списком друзей
    private func getFriendsDict(searchText: String?, list: [User]) -> [Character:[User]]{
        var tempUsers = list
        if let text = searchText?.lowercased(), searchText != "" {
            tempUsers = list.filter{ $0.name.lowercased().contains(text) }
        } else {
            tempUsers = list
        }
        let sortedUsers = Dictionary.init(grouping: tempUsers)
            { $0.name.lowercased().first ?? "#" }
            .mapValues{ $0.sorted
            { $0.name.lowercased() < $1.name.lowercased() }
            }
        self.tableView.reloadData()
        return sortedUsers
    }
    
    /// Метод добавляющий контрол перехода по букве
    private func setLettersControl(){
        // Присваиваем контрол и разворачиваем опционал
        lettersControl = LettersControl()
        guard let lettersControl = lettersControl else {
            return
        }
        // Добавляем контрол в сабвью
        view.addSubview(lettersControl)
        // Задаем внешний вид контрола
        lettersControl.translatesAutoresizingMaskIntoConstraints = false
        lettersControl.arrChar = firstLetters
        lettersControl.backgroundColor = .clear
        // Задаем действие по нажатию
        lettersControl.addTarget(
            self,
            action: #selector(scrollToSelectedLetter),
            for: [.touchUpInside])
        // Задаем констрейнты
        NSLayoutConstraint.activate([
            lettersControl.heightAnchor.constraint(
                equalToConstant: CGFloat(15*lettersControl.arrChar.count)),
            lettersControl.centerYAnchor.constraint(
                equalTo: view.centerYAnchor),
            lettersControl.widthAnchor.constraint(
                equalToConstant: 20),
            lettersControl.trailingAnchor.constraint(
                equalTo: view.trailingAnchor)
        ])
        // Обновляем данные таблицы
        tableView.reloadData()
    }
    
    // MARK: Methods
    
    /// Метод для реализации поиска
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Перезаписываем словарь в соответствии с введенным текстом
        friendsDict = getFriendsDict(searchText: searchText, list: friends)
        // Обновляем данные в таблице
        tableView.reloadData()
    }
    
    /// Метод для перехода к нужной секции по нажатии на кнопку контрола
    @objc func scrollToSelectedLetter(){
        guard let lettersControl = lettersControl else {
            return
        }
        let selectLetter = lettersControl.selectedLetter
        for indexSection in 0..<firstLetters.count {
            if selectLetter == firstLetters[indexSection] {
                tableView.scrollToRow(
                    at: IndexPath(row: 0, section: indexSection),
                    at: .top, animated: true)
                break
            }
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
            // Задаем ключ
            let key = firstLetters[index.section]
            // Получаем массив друзей из словаря по ключу
            let friendsForKey = friendsDict[key]
            // Получаем данные конкретного друга
            guard let friend = friendsForKey?[index.row] else { return }
            // Добавляеем аватарку в массив
            friendCVC.friendPhotos.append(friend.avatar!)
        }
    }
}

//MARK: - UITableViewDataSource

extension FriendsViewController: UITableViewDataSource{
    
    // Метод задающий количество секций в таблице
    func numberOfSections(in tableView: UITableView) -> Int {
        // Возвращаем значение равное количеству ключей в словаре
        return friendsDict.keys.count
    }
    
    // Метод задающий количество строк в секции таблицы
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
        
        // Проверяем чтоб словарь не был пустым
        guard !firstLetters.isEmpty else { return 0 }
        // Задаем ключ
        let key = firstLetters[section]
        // Возвращаем количество друзей из словаря по ключу
        return friendsDict[key]?.count ?? 0
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Получаем ячейку из пула и проверяем, что ячейка нужного типа
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "friendsCells",
                for: indexPath) as? FriendsCell
        // Иначе возвращаем пустую ячейку
        else { return UITableViewCell() }
        
        // Задаем ключ
        let key = firstLetters[indexPath.section]
        // Получаем массив друзей из словаря по ключу
        let friendsForKey = friendsDict[key]
        // Получаем данные конкретного друга для каждой строки по индексу строки
        guard let friend = friendsForKey?[indexPath.row] else { return cell }
        // Присваиваем данные каждой строке
        cell.configure(user: friend)
        return cell
    }
    
    
    // Метод задающий хэдер секциям
    func tableView(
        _ tableView: UITableView,
        titleForHeaderInSection section: Int) -> String? {
        
        let letter = firstLetters[section].uppercased()
        let header = String(letter)
        return header
    }
}


//MARK: - UITableViewDelegate

extension FriendsViewController: UITableViewDelegate {
    // Метод выделения ячейки
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath) {
        
        //defer конструкция которая всегда выполняется в конце кода
        //в независимоти от места ее написания
        defer {
            // Метод для снятия выделения с ячейки
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
    }
    
    // Метод задающий высоту ячейки таблицы
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
    
    // Метод задающий высоту хэдера
    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int) -> CGFloat {
        
        return 15
    }
    
    func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath) {
        
        let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
        cell.transform = scale
        cell.alpha = 0.3
        
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 1,
                       options: [.curveEaseInOut],
                       animations: {
                        cell.transform = .identity
                        cell.alpha = 1
                       })
    }
}
