//
//  MBAlerts.swift
//  mab
//
//  Created by Shuo Wang on 4/6/20.
//  Copyright © 2020 Shuo Wang. All rights reserved.
//

import UIKit
import MBProgressHUD

final class MBAlerts {

    static private var loadingView: MBProgressHUD!
    
    /// show toast
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
    /// show toast on windows
    static func showToastOnWindow(_ text: String, delay: TimeInterval = 2) {
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        showToast(on: window, text: text, isOnBottom: true, delay: delay)
    }
    
    /// centre the toast
    static func showCenterToastOnWindow(_ text: String, delay: TimeInterval = 2) {
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        showToast(on: window, text: text, isOnBottom: false, delay: delay)
    }
    
    /// show specific toast
    static func showToast(on view: UIView, text: String, delay: TimeInterval = 2) {
        showToast(on: view, text: text, isOnBottom: true, delay: delay)
    }
    
    /// show centre toast
    static func showCenterToast(on view: UIView, text: String, delay: TimeInterval = 2) {
        showToast(on: view, text: text, isOnBottom: false, delay: delay)
    }
    
    
    /// loading
    static func showLoading() {
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        showLoading(on: window)
    }
    
    /// show loading in the view
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
    
    /// hide loading
    static func hideLoading() {
        DispatchQueue.main.async {
            loadingView.hide(animated: true)
            loadingView = nil
        }
    }

}
