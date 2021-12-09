//
//  PhotoCell.swift
//  VKApp_TalalayVV
//
//  Created by Vitaliy Talalay on 14.11.2021.
//

import UIKit

class PhotoCell: UITableViewCell {
    
    let newsImage = UIImageView()
    
    override func prepareForReuse() {
        newsImage.image = nil
    }
    
    func setupViews() {
        newsImage.translatesAutoresizingMaskIntoConstraints = false
        newsImage.contentMode = .scaleAspectFill
        newsImage.backgroundColor = .systemBackground
        newsImage.isOpaque = true
        
        contentView.addSubview(newsImage)
        
        contentView.backgroundColor = .systemBackground
        contentView.isOpaque = true
        
        NSLayoutConstraint.activate([
            newsImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            newsImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            newsImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            newsImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
