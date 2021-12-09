//
//  TextCell.swift
//  VKApp_TalalayVV
//
//  Created by Vitaliy Talalay on 14.11.2021.
//

import UIKit

protocol TextCellDelegate {
    func contentDidChange (cell: TextCell)
}

class TextCell: UITableViewCell {

    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var ShowMoreButton: UIButton!
    
    var isTextFull = false
    var delegate: TextCellDelegate?
   
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func prepareForReuse() {
        postTextLabel.text = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func buttonPress(_ sender: Any) {
        if sender is UIButton {
            isTextFull = !isTextFull
            ShowMoreButton.setTitle(nameForButton(), for: .normal)
        }
        delegate?.contentDidChange(cell: self)
    }
    
    private func nameForButton() -> String {
        return (isTextFull ? "Скрыть" : "Показать полностью")
    }
    
    public func cellInit(text: String?, isShowMoreBtn: Bool) {
        postTextLabel.text = text
        if isShowMoreBtn {
            isTextFull = false
            ShowMoreButton.setTitle(nameForButton(), for: .normal)
            ShowMoreButton.isHidden = false
        } else {
            ShowMoreButton.isHidden = true
        }
    }
}
