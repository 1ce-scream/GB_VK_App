//
//  SectionHeader.swift
//  VKApp_TalalayVV
//
//  Created by Vitaliy Talalay on 14.11.2021.
//

import UIKit

class SectionHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    
    static var nib: UINib {
            return UINib(nibName: String(describing: self), bundle: nil)
        }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
