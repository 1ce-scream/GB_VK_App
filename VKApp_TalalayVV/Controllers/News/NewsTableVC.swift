//
//  News0.swift
//  VKApp_TalalayVV
//
//  Created by Vitaliy Talalay on 14.11.2021.
//

import UIKit
import Nuke

class News: UITableViewController {
    
    private var news = [NewsModel]()
    private let networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkService.getNews(onComplete: { [weak self] (news) in
            self?.news = news
            self?.tableView.reloadData()
        })
        
        tableView.delegate = self
        tableView.dataSource = self
        
        registerNib()
        
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
            let textCell = tableView.dequeueReusableCell(
                withIdentifier: "TextCell",
                for: indexPath) as! TextCell
            let photoCell = tableView.dequeueReusableCell(
                withIdentifier: "PhotoCell",
                for: indexPath) as! PhotoCell
            textCell.postTextLabel.text = news[section].text
            
            switch indexPath.row {
            case 0:
                textCell.postTextLabel.numberOfLines = 0
                textCell.postTextLabel.text = news[section].text
                return textCell
                
            case 1:
                photoCell.photoView.setImages(photos: news[section].photosURL!)
//                    photos: photoCell.photoView.loadImages(
//                        photosUrl: news[section].photosURL!))
                return photoCell
                
            default:
                return UITableViewCell()
            }
        }
    
    override func tableView(_: UITableView,
                            heightForRowAt _: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
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
