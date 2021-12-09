//
//  News0.swift
//  VKApp_TalalayVV
//
//  Created by Vitaliy Talalay on 14.11.2021.
//

import UIKit
import Nuke
import SwiftUI

class News: UITableViewController, TextCellDelegate {

    private var news = [NewsModel]()
    private var nextFrom: String!
    private var isLoading = false
    private let networkService = NetworkService()
    private let textFont = UIFont.systemFont(ofSize: 16)
    private let maxHeightTextCell: CGFloat = 200
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkService.getNews(onComplete: { [weak self] (news , nextFrom) in
            self?.news = news
            self?.nextFrom = nextFrom
            self?.tableView.reloadData()
        })
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        
        registerNib()
        setupRefreshControl()
    }
    
    private func registerNib() {
        tableView.register(SectionHeader.nib,
                           forHeaderFooterViewReuseIdentifier: "Header"
        )
        
        tableView.register(SectionFooter.nib,
                           forHeaderFooterViewReuseIdentifier: "Footer"
        )
        
        let nibText = UINib(nibName: "TextCell", bundle: nil)
        tableView.register(nibText, forCellReuseIdentifier: "TextCell")
        
        let nibPhoto = UINib(nibName: "PhotoCell", bundle: nil)
        tableView.register(nibPhoto, forCellReuseIdentifier: "PhotoCell")
    }
    
    fileprivate func setupRefreshControl() {
        tableView.refreshControl = UIRefreshControl()
        
        tableView.refreshControl?.attributedTitle = NSAttributedString(
            string: "Обновление...")
        tableView.refreshControl?.tintColor = .systemBlue
        tableView.refreshControl?.addTarget(
            self,
            action: #selector(refreshNews),
            for: .valueChanged)
    }
    
    func contentDidChange(cell: TextCell) {
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
        
//        guard let indexPath = tableView.indexPath(for: cell) else { return }
//        cell.isTextFull.toggle()
//        self.tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    @objc func refreshNews() {
        tableView.refreshControl?.beginRefreshing()
        
        let mostFreshNewsDate = self.news.first?.date ?? Date().timeIntervalSince1970
        
        networkService.getNews(startTime: String(mostFreshNewsDate + 1),
                               onComplete: { [weak self] (news, nextFrom) in
            
            guard
                let self = self,
                    news.count > 0
            else {
                self!.tableView.refreshControl?.endRefreshing()
                return }
            
            self.news = news + self.news
            let indexSet = IndexSet(integersIn: 0..<news.count)
            self.tableView.insertSections(indexSet, with: .automatic)
        })
        
        tableView.refreshControl?.endRefreshing()
    }
    
    override func tableView(_ tableView: UITableView,
                            viewForHeaderInSection section: Int) -> UIView? {
        
        guard let header = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: "Header") as? SectionHeader
        else { return nil }
        
        header.nameLabel.text = news[section].creatorName
        header.dateLabel.text = news[section].getStringDate()
        
        let urlString = news[section].avatarURL
        if let url = URL(string: urlString ?? "") {
            Nuke.loadImage(with: url, into: header.avatarImageView!)
        }
        
        return header
    }
    
    override func tableView(_ tableView: UITableView,
                            viewForFooterInSection section: Int) -> UIView? {
        
        guard let footer = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: "Footer") as? SectionFooter
        else { return nil }
        
        footer.viewCount.text = "Просмотров: " + String(news[section].views.count)
        footer.likeControll.setLike(count: news[section].likes.count)
        return footer
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return news.count
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let section = indexPath.section
            
            switch indexPath.row {
            case 0:
                guard
                    let textCell = tableView.dequeueReusableCell(
                        withIdentifier: "TextCell",
                        for: indexPath) as? TextCell
                else { return UITableViewCell() }
                
                let textHeight = news[section].text.getTextHeight(
                    width: tableView.frame.width,
                    font: textFont)
                
                textCell.cellInit(
                    text: news[section].text,
                    isShowMoreBtn: textHeight > maxHeightTextCell)
                textCell.delegate = self
                return textCell
            case 1:
                guard
                    let photoCell = tableView.dequeueReusableCell(
                        withIdentifier: "PhotoCell",
                        for: indexPath) as? PhotoCell
                else { return UITableViewCell()}
                
                let urlString = news[section].photosURL?.last
                
                if let url = URL(string: urlString ?? "") {
                    Nuke.loadImage(with: url, into: photoCell.newsImage)
                }
                return photoCell
                
            default:
                return UITableViewCell()
            }
        }
    
    override func tableView(_: UITableView,
                            heightForRowAt indexPath: IndexPath) -> CGFloat {

        let news = news[indexPath.section]
        let tableWidth = tableView.bounds.width
        
        switch indexPath.row {
        case 0:
            let text =  news.text
            if text == "" { return 0 }
            let cell = tableView.cellForRow(at: indexPath) as? TextCell
            return (cell?.isTextFull ?? false) ? UITableView.automaticDimension : maxHeightTextCell
        
        case 1:
            let photoSizes = news.attachments!.last!.photo?.sizes
            if photoSizes == nil { return 0 }
            guard
                let ratio = photoSizes?.last?.aspectRatio
            else { return UITableView.automaticDimension }
            let cellHeight = tableWidth * ratio
            return cellHeight
        
        default:
            return UITableView.automaticDimension
        }
    }
   
    override func tableView(_: UITableView,
                            estimatedHeightForRowAt _: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    override func tableView(_: UITableView,
                            heightForHeaderInSection _: Int) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    override func tableView(_: UITableView,
                            estimatedHeightForHeaderInSection _: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView,
                            heightForFooterInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
//    override func tableView(_ tableView: UITableView,
//                            estimatedHeightForFooterInSection section: Int) -> CGFloat {
//        return 50
//    }
}

extension News: UITableViewDataSourcePrefetching {
    func tableView(
        _ tableView: UITableView,
        prefetchRowsAt indexPaths: [IndexPath]) {
        
            guard
                let maxSection = indexPaths.map({ $0.section }).max()
            else { return }
            
            if maxSection > news.count - 3, !isLoading {
                isLoading = true
                
                networkService.getNews(startFrom: nextFrom) {
                    [weak self] news,nextFrom  in
                    
                    guard let self = self else { return }
                    let indexSet = IndexSet(
                        integersIn: self.news.count ..<
                        self.news.count + news.count)
                    
                    self.nextFrom = nextFrom
                    self.news.append(contentsOf: news)
                    self.tableView.insertSections(indexSet, with: .automatic)
                    self.isLoading = false
                }
            }
        }
}
