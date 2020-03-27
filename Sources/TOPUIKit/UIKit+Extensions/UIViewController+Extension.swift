//
//  UIViewController+Extensions.swift
//  TOPUIKit
//
//  Created by c on 2020/3/27.

import UIKit

public extension UIViewController {

    /// 添加子视图
    /// - Parameter childController: 子视图
    func add(_ childController: UIViewController) {

        childController.willMove(toParent: self)
        addChild(childController)
        view.addSubview(childController.view)
        childController.didMove(toParent: self)
    }

    /// 获取APP当前显示中的控制器
    /// - Parameter base: 当前页面，可以是UINavigationController 或者 UITabBarController
    /// - Returns: 当前栈顶视图
    class func currentViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return currentViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return currentViewController(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return currentViewController(base: presented)
        }
        return base
    }
}
