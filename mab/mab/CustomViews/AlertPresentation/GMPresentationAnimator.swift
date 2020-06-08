//
//  GMPresentationAnimator.swift
//  TestDemo
//
//  Created by Leo on 2018/11/1.
//  Copyright © 2018 Leo. All rights reserved.
//

import UIKit

/// Modal动画控制类
class GMPresentationAnimator: NSObject {
    
    private var isPresentation: Bool
    private var position: GMPresentationPosition
    private var alertSize: CGSize
    private var customY: CGFloat
    
    init(isPresentation: Bool, manager: GMPresentationManager) {
        self.isPresentation = isPresentation
        self.position = manager.position
        self.alertSize = manager.size
        self.customY = manager.customY
        super.init()
    }
}

extension GMPresentationAnimator: UIViewControllerAnimatedTransitioning {
    
    // 设置动画时长
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.32
    }
    
    // 设置动画
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let key = isPresentation ? UITransitionContextViewControllerKey.to : UITransitionContextViewControllerKey.from
        
        guard let controller = transitionContext.viewController(forKey: key) else { return }
        if isPresentation {
            transitionContext.containerView.addSubview(controller.view)
        }
        
        let presentedFrame = transitionContext.finalFrame(for: controller)
        var dismissedFrame = presentedFrame
        switch position {
        case .top, .customY:
            dismissedFrame.origin.y = -alertSize.height
        case .center, .bottom:
            dismissedFrame.origin.y = transitionContext.containerView.frame.size.height
        }
        
        let initialFrame = isPresentation ? dismissedFrame : presentedFrame
        let finalFrame = isPresentation ? presentedFrame : dismissedFrame
        
        let animationDuration = transitionDuration(using: transitionContext)
        
        controller.view.frame = initialFrame
        
        UIView.animate(withDuration: animationDuration, animations: {
            controller.view.frame = finalFrame
        }) { (finished) in
            transitionContext.completeTransition(finished)
        }
        
    }
    
    
    
    
}


