//
//  SectionFooter.swift
//  VKApp_TalalayVV
//
//  Created by Vitaliy Talalay on 14.11.2021.
//

import UIKit

class SectionFooter: UITableViewHeaderFooterView {
   

    @IBOutlet weak var repostButton: UIButton!
    @IBOutlet weak var likeControll: LikeControl!
    @IBOutlet weak var viewCount: UILabel!
    
    static var nib: UINib {
            return UINib(nibName: String(describing: self), bundle: nil)
        }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.viewCount.backgroundColor = .systemBackground
        self.viewCount.isOpaque = true
        self.repostButton.backgroundColor = .systemBackground
        self.repostButton.isOpaque = true 
    }

}
