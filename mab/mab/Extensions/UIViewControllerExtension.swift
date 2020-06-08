//
//  UIViewControllerExtension.swift
//  EHealthHanAn
//
//  Created by Shuo Wang on 24/5/20.
//  Copyright © 2020 Shuo Wang. All rights reserved.
//

import UIKit

// MARK: - load from Storyboard
protocol MBStoryboardable {}
extension MBStoryboardable where Self: UIViewController {
    
    /// load from Storyboard
    static func instanceFromStoryboard(named sbName: String) -> Self {
        let storyboard = UIStoryboard(name: sbName, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "\(self)")
        return vc as! Self
    }
    
}

// MARK: - navi button
extension UIViewController {
    
    @discardableResult
    final func addLeftNaviBarButton(image: UIImage? = nil, title: String? = nil, action: Selector? = nil) -> UIBarButtonItem? {
        return addNaviBarItem(image: image, title: title, action: action, isleft: true)
    }
    
    @discardableResult
    final func addRightNaviBarButton(image: UIImage? = nil, title: String? = nil, action: Selector? = nil) -> UIBarButtonItem? {
        return addNaviBarItem(image: image, title: title, action: action, isleft: false)
    }
    
    final func addCustomLeftNaviBarItem(_ view: UIView) {
        addCustomNaviBarItem(view, isleft: true)
    }
    
    final func addCustomRightNaviBarItem(_ view: UIView) {
        addCustomNaviBarItem(view, isleft: false)
    }
    
    /// add custom navi button
    private func addCustomNaviBarItem(_ view: UIView, isleft: Bool) {
        let newItem = UIBarButtonItem(customView: view)
        addNaviBarItem(newItem, isleft: isleft)
    }
    
    /// add system navi item
    private func addNaviBarItem(image: UIImage?, title: String?, action: Selector?, isleft: Bool) -> UIBarButtonItem? {
        guard let newItem = getBarButton(image: image, title: title, action: action) else { return nil }
        addNaviBarItem(newItem, isleft: isleft)
        return newItem
    }
    
    /// add navi button
    private func addNaviBarItem(_ newItem: UIBarButtonItem, isleft: Bool) {
        if isleft {
            // navi left top button
            if var items = navigationItem.leftBarButtonItems, items.count > 0 {
                items.append(newItem)
                navigationItem.leftBarButtonItems = items
            }else if let item = navigationItem.leftBarButtonItem {
                navigationItem.leftBarButtonItems = [item, newItem]
            }else {
                navigationItem.leftBarButtonItem = newItem
            }
        }else {
            // navi right top button
            if var items = navigationItem.rightBarButtonItems, items.count > 0 {
                items.append(newItem)
                navigationItem.rightBarButtonItems = items
            }else if let item = navigationItem.rightBarButtonItem {
                navigationItem.rightBarButtonItems = [item, newItem]
            }else {
                navigationItem.rightBarButtonItem = newItem
            }
        }
    }
    
    /// create bar button
    private func getBarButton(image: UIImage?, title: String?, action:Selector?) -> UIBarButtonItem? {
        var barButton: UIBarButtonItem?
        if image != nil {
            barButton = UIBarButtonItem(image: image, style: .plain, target: self, action: action)
        } else if title != nil {
            barButton = UIBarButtonItem(title: title!, style: .plain, target: self, action: action)
        }
        return barButton
    }
    
}
