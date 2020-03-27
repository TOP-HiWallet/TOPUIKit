//
//  UILabel.swift
//  TOPUIKit
//
//  Created by Jax on 2020/3/27.
//

import UIKit

public extension UILabel {

    /// 设置行间距和字体
    /// - Parameters:
    ///   - space: 行间距
    ///   - font: 字体大小
    func setCustomLineSpacingAndFont(space: CGFloat, font: UIFont) {
        guard let txt = self.text else { return }
        let attributeString = NSMutableAttributedString(string: txt, attributes: [NSAttributedString.Key.font: font])
        let attributeStyle = NSMutableParagraphStyle()
        attributeStyle.lineSpacing = space
        attributeString.addAttribute(NSAttributedString.Key.paragraphStyle, value: attributeStyle, range: NSMakeRange(0, attributeString.length))
        attributedText = attributeString
        sizeToFit()
    }
}
