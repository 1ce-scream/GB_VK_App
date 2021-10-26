//
//  NewsViewController.swift
//  VKApp_TalalayVV
//
//  Created by Vitaliy Talalay on 06.09.2021.
//

import UIKit

class NewsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var news = [NewsModel]()
    let networkService = NetworkService()
    var photos: [String]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkService.getNews(onComplete: { [weak self] (news) in
                    self?.news = news
                    self?.tableView.reloadData()
                })
//        networkService.getNews()
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

}

extension NewsViewController: UITableViewDataSource{
    
    // Метод задающий количество секций в таблице
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    // Метод задающий количество строк в секции таблицы
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Получаем ячейку из пула и проверяем, что ячейка нужного типа
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "newsCell",
                for: indexPath) as? NewsCell
        // Иначе возвращаем пустую ячейку
        else { return UITableViewCell() }
        
        cell.configure(news: news[indexPath.row])
        return cell
    }
}

//MARK: - UITableViewDelegate

extension NewsViewController: UITableViewDelegate {
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
        return UITableView.automaticDimension
    }
}
