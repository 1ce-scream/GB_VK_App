//
//  PhotoCell.swift
//  VKApp_TalalayVV
//
//  Created by Vitaliy Talalay on 14.11.2021.
//

import UIKit

class PhotoCell: UITableViewCell {

    @IBOutlet weak var photoView: PhotoView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
