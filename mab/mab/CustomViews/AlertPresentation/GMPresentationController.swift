//
//  GMPresentationController.swift
//  TestDemo
//
//  Created by Leo on 2018/11/1.
//  Copyright © 2018 Leo. All rights reserved.
//

import UIKit

/// Modal跳转中转控制器
class GMPresentationController: UIPresentationController {
    
    private var alertSize: CGSize
    private var alertPosition: GMPresentationPosition
    private var needFocusOn: Bool
    private var customY: CGFloat
    /// 弹框预想的位置
    override var frameOfPresentedViewInContainerView: CGRect {
        var frame: CGRect = .zero
        frame.size = size(forChildContentContainer: presentedViewController, withParentContainerSize: containerView!.bounds.size)
        switch alertPosition {
        case .top:
            frame.origin.y = 0
        case .center:
            let x = (containerView!.frame.width-alertSize.width)*0.5
            let y = (containerView!.frame.height-alertSize.height)*0.5
            frame.origin = CGPoint(x: x, y: y)
        case .bottom:
            frame.origin.y = containerView!.frame.height-alertSize.height
        case .customY:
            let x = (containerView!.frame.width-alertSize.width)*0.5
            frame.origin = CGPoint(x: x, y: customY)
        }
        return frame
    }
    
    fileprivate var dimmingView: UIView!
    
    init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, manager: GMPresentationManager) {
        self.alertPosition = manager.position
        self.alertSize = manager.size
        self.needFocusOn = manager.needFocusOn
        self.customY = manager.customY
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        setupDimmingView()
    }
    
    /// 弹出前
    override func presentationTransitionWillBegin() {
        // 插入背景
        containerView?.insertSubview(dimmingView, at: 0)
        /// 给背景添加自动布局
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[dimmingView]|", options: [], metrics: nil, views: ["dimmingView": dimmingView!]))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[dimmingView]|", options: [], metrics: nil, views: ["dimmingView": dimmingView!]))
        
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 1.0
            return
        }
        
        coordinator.animate(alongsideTransition: { (_) in
            self.dimmingView.alpha = 1.0
        }, completion: nil)
        
    }
    
    /// 消失前
    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 0.0
            return
        }
        
        coordinator.animate(alongsideTransition: { (_) in
            self.dimmingView.alpha = 0.0
        }, completion: nil)
    }
    
    override func containerViewWillLayoutSubviews() {
        presentedViewController.view.frame = frameOfPresentedViewInContainerView
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        switch alertPosition {
        case .top, .bottom:
            return CGSize(width: parentSize.width, height: alertSize.height)
        case .center, .customY:
            return alertSize
        }
    }
    
}

private extension GMPresentationController {
    /// 设置半透明背景
    func setupDimmingView() {
        dimmingView = UIView()
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        dimmingView.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        dimmingView.alpha = 0.0
        // 添加手势
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
        dimmingView.addGestureRecognizer(recognizer)
    }
    
    @objc func handleTap(recognizer: UITapGestureRecognizer) {
        guard !needFocusOn else {
            return
        }
        presentingViewController.dismiss(animated: true, completion: nil)
    }
}
