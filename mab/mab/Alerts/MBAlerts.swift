//
//  MBAlerts.swift
//  mab
//
//  Created by zhengheng on 2020/6/2.
//  Copyright © 2020 Shuo Wang. All rights reserved.
//

import UIKit
import MBProgressHUD

final class MBAlerts {

    static private var loadingView: MBProgressHUD!
    
    /// 显示toast
    static private func showToast(on view: UIView, text: String, isOnBottom: Bool, delay: TimeInterval = 1.5) {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .text
        hud.label.text = text
        hud.label.numberOfLines = 0
        // Move to bottm center.
        if isOnBottom {
            hud.offset = CGPoint(x: 0, y: MBProgressMaxOffset)
        }
        hud.hide(animated: true, afterDelay: delay)
    }
}

extension MBAlerts {
    /// 在当前window上弹框
    static func showToastOnWindow(_ text: String, delay: TimeInterval = 2) {
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        showToast(on: window, text: text, isOnBottom: true, delay: delay)
    }
    
    /// 在当前window上弹框（center）
    static func showCenterToastOnWindow(_ text: String, delay: TimeInterval = 2) {
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        showToast(on: window, text: text, isOnBottom: false, delay: delay)
    }
    
    /// 在指定view上弹框
    static func showToast(on view: UIView, text: String, delay: TimeInterval = 2) {
        showToast(on: view, text: text, isOnBottom: true, delay: delay)
    }
    
    /// 在指定view上弹框（center）
    static func showCenterToast(on view: UIView, text: String, delay: TimeInterval = 2) {
        showToast(on: view, text: text, isOnBottom: false, delay: delay)
    }
    
    
    /// 在window上显示加载
    static func showLoading() {
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        showLoading(on: window)
    }
    
    /// 在view上显示加载
    static func showLoading(on view: UIView) {
        if loadingView != nil && view.subviews.contains(loadingView!) {
            loadingView?.isHidden = false
            return
        }
        
        DispatchQueue.main.async {
            let hud = MBProgressHUD.showAdded(to: view, animated: true)
            hud.mode = .indeterminate
            loadingView = hud
        }
    }
    
    /// 隐藏加载
    static func hideLoading() {
        DispatchQueue.main.async {
            loadingView.hide(animated: true)
            loadingView = nil
        }
    }

}
