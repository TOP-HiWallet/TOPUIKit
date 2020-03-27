//
//  UIView+Extension.swift
//  TOPUIKit
//
//  Created by Jax on 2020/3/27.
//

import UIKit

// MARK: - Frame

public extension UIView {

    /// X坐标
    var x: CGFloat {
        get { return frame.origin.x }
        set {
            var tempframe: CGRect = frame
            tempframe.origin.x = newValue
            frame = tempframe
        }
    }

    /// Y坐标
    var y: CGFloat {
        get { return frame.origin.y }
        set {
            var tempframe: CGRect = frame
            tempframe.origin.y = newValue
            frame = tempframe
        }
    }

    /// 高
    var height: CGFloat {
        get { return frame.size.height }
        set {
            var tempframe: CGRect = frame
            tempframe.size.height = newValue
            frame = tempframe
        }
    }

    /// 宽
    var width: CGFloat {
        get { return frame.size.width }
        set {
            var tempframe: CGRect = frame
            tempframe.size.width = newValue
            frame = tempframe
        }
    }

    /// centerX
    var centerX: CGFloat {
        get { return center.x }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.x = newValue
            center = tempCenter
        }
    }

    /// centerY
    var centerY: CGFloat {
        get { return center.y }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.y = newValue
            center = tempCenter
        }
    }
}

// MARK: - 阴影，边框 ，圆角

public extension UIView {
    // 阴影颜色
    @IBInspectable var shadowColor: UIColor? {
        set {
            layer.shadowColor = newValue!.cgColor
        }
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            } else {
                return nil
            }
        }
    }

    /* The opacity of the shadow. Defaults to 0. Specifying a value outside the
     * [0,1] range will give undefined results. Animatable. */
    @IBInspectable var shadowOpacity: Float {
        set {
            layer.shadowOpacity = newValue
        }
        get {
            return layer.shadowOpacity
        }
    }

    /* The shadow offset. Defaults to (0, -3). Animatable. */
    @IBInspectable var shadowOffset: CGPoint {
        set {
            layer.shadowOffset = CGSize(width: newValue.x, height: newValue.y)
        }
        get {
            return CGPoint(x: layer.shadowOffset.width, y: layer.shadowOffset.height)
        }
    }

    /* The blur radius used to create the shadow. Defaults to 3. Animatable. */
    @IBInspectable var shadowRadius: CGFloat {
        set {
            layer.shadowRadius = newValue
        }
        get {
            return layer.shadowRadius
        }
    }

    // 边框
    @IBInspectable var borderColor: UIColor? {
        set {
            layer.borderColor = newValue!.cgColor
        }
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            } else {
                return nil
            }
        }
    }

    /// 设置边框
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    /// 设置圆角
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
}

public extension UIView {

    // 清除约束
    func clearConstrains() {
        for constain in constraints {
            removeConstraint(constain)
        }
    }

    /// 设置渐变色
    /// - Parameters:
    ///   - rect: 区域
    ///   - radius: 圆角
    ///   - colors: 颜色集合
    func addBGGradient(_ rect: CGRect = .zero, radius: CGFloat = 0, colors: [CGColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = (rect == .zero) ? bounds : rect
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.colors = colors
        gradientLayer.locations = [0, 1]
        gradientLayer.cornerRadius = radius
        layer.insertSublayer(gradientLayer, at: 0)
    }

    /// 绘图的方式设置圆角
    /// - Parameters:
    ///   - corners: 圆角位置
    ///   - radius: 圆角大小
    func addRounderCorner(corners: UIRectCorner, radius: CGSize) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: radius)
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        layer.mask = shape
    }

    /// 设置阴影工厂化方法
    func setShadow(offset: CGSize = .zero, color: UIColor = .black, radius: CGFloat, opacity: Float = 0.1) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
    }

    /// 同时设置 view 的阴影和圆角
    /// - Parameters:
    ///   - radius: 圆角数值
    ///   - effect: 阴影向外衍射的程度
    ///   - offset: 整体阴影的偏移量
    ///   - color: 阴影颜色
    ///   - opacity: 阴影的透明度
    func setRadiusAndShadow(
        radius: CGFloat,
        effect: CGFloat,
        offset: CGSize = .zero,
        color: UIColor = .black,
        opacity: Float = 0.16
    ) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.shadowRadius = effect
        layer.cornerRadius = radius
        layer.backgroundColor = UIColor.white.cgColor
    }
}

// MARK: - 抖动效果

public extension UIView {

    // 抖动方向枚举
    enum ShakeDirection: Int {
        case horizontal // 水平抖动
        case vertical // 垂直抖动
    }

    /**
     扩展UIView增加抖动方法

     @param direction：抖动方向（默认是水平方向）
     @param times：抖动次数（默认5次）
     @param interval：每次抖动时间（默认0.1秒）
     @param delta：抖动偏移量（默认3）
     @param completion：抖动动画结束后的回调
     */
    func shake(
        direction: ShakeDirection = .horizontal, times: Int = 5,
        interval: TimeInterval = 0.06, delta: CGFloat = 3,
        completion: (() -> Void)? = nil
    ) {
        // 播放动画
        UIView.animate(withDuration: interval, animations: { () -> Void in
            switch direction {
            case .horizontal:
                self.layer.setAffineTransform(CGAffineTransform(translationX: delta, y: 0))
                break
            case .vertical:
                self.layer.setAffineTransform(CGAffineTransform(translationX: 0, y: delta))
                break
            }
        }) { (_) -> Void in
            // 如果当前是最后一次抖动，则将位置还原，并调用完成回调函数
            if times == 0 {
                UIView.animate(withDuration: interval, animations: { () -> Void in
                    self.layer.setAffineTransform(CGAffineTransform.identity)
                }, completion: { (_) -> Void in
                    completion?()
                })
            }
            // 如果当前不是最后一次抖动，则继续播放动画（总次数减1，偏移位置变成相反的）
            else {
                self.shake(
                    direction: direction, times: times - 1, interval: interval,
                    delta: delta * -1, completion: completion
                )
            }
        }
    }
}
