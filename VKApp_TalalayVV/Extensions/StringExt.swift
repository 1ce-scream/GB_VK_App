//
//  StringExt.swift
//  VKApp_TalalayVV
//
//  Created by Vitaliy Talalay on 08.12.2021.
//

import UIKit

extension String {
    func getTextHeight(width: CGFloat, font: UIFont) -> CGFloat {
        let textBlock = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let rect = self.boundingRect(with: textBlock,
                                     options:.usesLineFragmentOrigin,
                                     attributes: [NSAttributedString.Key.font: font],
                                     context: nil)
        
        let height = Double(rect.size.height)
        return CGFloat(height).rounded(.up)
    }
}
