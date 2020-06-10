//
//  GMPresentationController.swift
//  mab
//
//  Created by Shuo Wang on 4/6/20.
//  Copyright © 2020 Shuo Wang. All rights reserved.
//

import UIKit

/// Modal transfer
class GMPresentationController: UIPresentationController {
    
    private var alertSize: CGSize
    private var alertPosition: GMPresentationPosition
    private var needFocusOn: Bool
    private var customY: CGFloat
    /// frame present position
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
    
    /// before presentation
    override func presentationTransitionWillBegin() {
        // insert background
        containerView?.insertSubview(dimmingView, at: 0)
        /// auto add layout
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
    
    /// before dismiss
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
    /// setting dimming
    func setupDimmingView() {
        dimmingView = UIView()
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        dimmingView.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        dimmingView.alpha = 0.0
        // add recognizer
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
