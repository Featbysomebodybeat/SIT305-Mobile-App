//
//  GMPresentationManager.swift
//  mab
//
//  Created by Shuo Wang on 4/6/20.
//  Copyright © 2020 Shuo Wang. All rights reserved.
//

import UIKit

/// 弹窗位置
@objc enum GMPresentationPosition: NSInteger {
    case top, bottom, center, customY
}

/// Modal跳转管理
@objc class GMPresentationManager: NSObject {
    
    static let shared = GMPresentationManager(position: .bottom, size: .zero)
    
    /// 弹窗高度
    var size = CGSize.zero
    /// 弹窗位置
    var position = GMPresentationPosition.bottom
    
    /// 是否可以点击空白移除弹框
    var needFocusOn = false
    
    /// 自定义竖直方向距离顶部距离
    var customY: CGFloat = 0
    
    @objc init(position: GMPresentationPosition, size: CGSize) {
        self.position = position
        self.size = size
        super.init()
    }
    
    @objc init(customY: CGFloat, size: CGSize) {
        self.position = .customY
        self.size = size
        self.customY = customY
        super.init()
    }
    
}

extension GMPresentationManager: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return GMPresentationController(presentedViewController: presented, presenting: presenting, manager: self)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return GMPresentationAnimator(isPresentation: true, manager: self)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return GMPresentationAnimator(isPresentation: false, manager: self)
    }
    
}
