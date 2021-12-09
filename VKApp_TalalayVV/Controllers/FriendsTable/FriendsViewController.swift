//
//  FriendsTableViewController.swift
//  VKApp_TalalayVV
//
//  Created by Виталий Талалай on 16.08.2021.
//

import UIKit
import RealmSwift

class FriendsViewController: UIViewController, UISearchBarDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    // MARK: - Private properties
    /// Массив список друзей
    private var friends = [Friend]()
    private var data: Results<Friend>?
    /// Сетевые сервисы
    private let networkService = NetworkService()
    /// Токен уведомлений
    private var friendsNotification: NotificationToken?
    /// Словарь со списком друзей
    private var friendsDict = [Character:[Friend]]()
    /// Массив первых букв имен друзей
    private var firstLetters: [Character] {
        get {
            friendsDict.keys.sorted()
        }
    }
    /// Контрол по буквам имен
    private var lettersControl: LettersControl?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        searchBar.delegate = self
    
        loadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        friendsNotification?.invalidate()
    }
    
    // MARK: - Private methods
    
    /// Метод задающий словарь со списком друзей
    private func getFriendsDict(
        searchText: String?,
        list: [Friend]) -> [Character:[Friend]]{
            
            var tempUsers = list
            if let text = searchText?.lowercased(), searchText != "" {
                tempUsers = list.filter{ $0.firstName.lowercased().contains(text) }
            } else {
                tempUsers = list
            }
            let sortedUsers = Dictionary.init(grouping: tempUsers)
            { $0.firstName.lowercased().first ?? "#" }
            .mapValues{ $0.sorted
                { $0.firstName.lowercased() < $1.firstName.lowercased() }
            }
            self.tableView.reloadData()
            return sortedUsers
        }
    
    /// Метод добавляющий контрол перехода по букве
    private func setLettersControl(){
        lettersControl = LettersControl()
        guard let lettersControl = lettersControl else {
            return
        }
        view.addSubview(lettersControl)
        
        lettersControl.translatesAutoresizingMaskIntoConstraints = false
        lettersControl.arrChar = firstLetters
        lettersControl.backgroundColor = .clear
        
        lettersControl.addTarget(
            self,
            action: #selector(scrollToSelectedLetter),
            for: [.touchUpInside])
        
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
        tableView.reloadData()
    }
    
    // MARK: - Methods
    
    /// Метод для агрузки данных (сеть + realm)
    func loadData() {
        networkService.getFriendsPromise()
            .then(networkService.parseFriends(json:))
            .done { try? RealmService.save(items: $0) }
            .catch { print($0) }
        
        let tmpFriends = try? RealmService.load(typeOf: Friend.self)
        friendsNotification = tmpFriends?.observe(on: .main)
        { [weak self] realmChange in

            switch realmChange {
            case .initial(let objects):
                self?.data = objects
                self?.setFriends()
            case .update(let objects, _, _, _):
                self?.data = objects
                self?.setFriends()
            case .error(let error):
                print(error)
            }
        }
    }
    
    /// Метод для установки друзей
    func setFriends() {
        guard let data = self.data else { return }
        let tmpFriends = data.filter{ !$0.lastName.isEmpty }
        self.friends = Array(tmpFriends)
        self.friendsDict = self.getFriendsDict(searchText: nil, list: Array(tmpFriends))
        self.tableView.reloadData()
        self.setLettersControl()
    }
    
    /// Метод для реализации поиска
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Перезаписываем словарь в соответствии с введенным текстом
        friendsDict = getFriendsDict(searchText: searchText, list: friends)
        
        if searchText == "" {
            lettersControl?.isHidden = false
        }else{
            lettersControl?.isHidden = true
        }
        
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
       
        guard let friendCVC = segue.destination
                as? FriendsCollectionViewController
        else { return }
        
        if let index = tableView.indexPathForSelectedRow {
            let key = firstLetters[index.section]
            let friendsForKey = friendsDict[key]
            guard let friend = friendsForKey?[index.row] else { return }
            friendCVC.userID = friend.id
        }
    }
}

//MARK: - UITableViewDataSource

extension FriendsViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return friendsDict.keys.count
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            
            guard !firstLetters.isEmpty else { return 0 }
            let key = firstLetters[section]
            return friendsDict[key]?.count ?? 0
        }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            guard
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: "friendsCells",
                    for: indexPath) as? FriendsCell
            else { return UITableViewCell() }
            
            let key = firstLetters[indexPath.section]
            let friendsForKey = friendsDict[key]
            guard let friend = friendsForKey?[indexPath.row] else { return cell }
            cell.configure(user: friend)
            return cell
        }
    
    func tableView(
        _: UITableView,
        viewForHeaderInSection section: Int) -> UIView? {
            
            let view = UIView(frame: CGRect(
                x: 0,
                y: 0,
                width: view.frame.size.width,
                height: 14))
            
            let label = UILabel(frame: CGRect(
                x: 8,
                y: 0,
                width: view.frame.size.width,
                height: 14))
            
            let letter = firstLetters[section].uppercased()
            
            label.text = letter
            label.backgroundColor = .systemBackground
            label.isOpaque = true
            label.textColor = .black
            label.font = UIFont.boldSystemFont(ofSize: 14)
            view.addSubview(label)
            
            return view
        }
}


//MARK: - UITableViewDelegate

extension FriendsViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath) {
            
            defer {
                // Метод для снятия выделения с ячейки
                tableView.deselectRow(at: indexPath, animated: true)
            }
            
        }
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 52
        }
    
    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int) -> CGFloat {
            return 10
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
