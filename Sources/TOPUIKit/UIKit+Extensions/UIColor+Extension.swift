//
//  UIColor+Extension.swift
//  TOPUIKit
//
//  Created by Jax on 2020/3/27.
//

import UIKit

public extension UIColor {

    /// 通过hex字符串初始化Color
    /// - Parameters:
    ///   - hex: hex格式字符串
    ///   - alpha: 透明度
    convenience init(hex: String, alpha: CGFloat = 1.0) {

        let hexString = hex.hasPrefix("#") ? String(hex.dropFirst()) : hex

        let v = hexString.map { String($0) } + Array(repeating: "0", count: max(6 - hexString.count, 0))
        let r = CGFloat(Int(v[0] + v[1], radix: 16) ?? 0) / 255.0
        let g = CGFloat(Int(v[2] + v[3], radix: 16) ?? 0) / 255.0
        let b = CGFloat(Int(v[4] + v[5], radix: 16) ?? 0) / 255.0
        self.init(red: r, green: g, blue: b, alpha: alpha)

        /// 16进制字符串表示 "#FFFFFFF"
        var hexStr: String {
            let components = cgColor.components!
            let red = Float(components[0])
            let green = Float(components[1])
            let blue = Float(components[2])

            return String(format: "#%02lX%02lX%02lX", lroundf(red * 255), lroundf(green * 255), lroundf(blue * 255))
        }
    }

    /// 随机颜色
    /// - Returns: 随机颜色
    static func random() -> UIColor {
        let randomR = CGFloat(arc4random() % 255) / 255.0
        let randomG = CGFloat(arc4random() % 255) / 255.0
        let randomB = CGFloat(arc4random() % 255) / 255.0

        if #available(iOS 10.0, *) {
            return UIColor(displayP3Red: randomR, green: randomG, blue: randomB, alpha: 1.0)
        } else {
            return UIColor(red: randomR, green: randomG, blue: randomB, alpha: 1.0)
        }
    }
}
