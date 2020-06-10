//
//  MBBaseController.swift
//  mab
//
//  Created by Shuo Wang on 24/5/20.
//  Copyright © 2020 Shuo Wang. All rights reserved.
//

import UIKit

class MBBaseController: UIViewController, MBStoryboardable {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setBackItem()
    }
    
    func setup() {
//        navigationController?.navigationBar.isHidden = true
    }
    
    /// 设置返回按钮
    func setBackItem() {
        
        addLeftNaviBarButton(image: nil, title: "Back", action: #selector(backAction))
        
//        if let count = navigationController?.viewControllers.count, count > 1 {
//            let backbutton = GMButton(frame: CGRect(x: 20, y: 50, width: 36, height: 36))
//            backbutton.setBackgroundImage(MBImage.Bar.naviBack.image, for: .normal)
////            backbutton.setImage(MBImage.Bar.naviBack.image, for: .normal)
//            backbutton.backgroundColor = UIColor.white
//            backbutton.radius = 18
//            backbutton.shadowOffset = CGSize(width: 0, height: 0)
//            backbutton.shadowColor = MBColor.textDark
//            backbutton.shadowOpacity = 0.2
//            backbutton.shadowRadius = 3
//            backbutton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
//
//            view.addSubview(backbutton)
//        }
        
    }
    
    /// 点击返回按钮操作，子类可重写改方法实现自定义跳转
    @objc func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
    func push(_ vc: UIViewController, animated: Bool = true) {
        navigationController?.pushViewController(vc, animated: animated)
    }
    
    func pop(animated: Bool = true, toRoot: Bool = false) {
        if toRoot {
            navigationController?.popToRootViewController(animated: animated)
        }else {
            navigationController?.popViewController(animated: animated)
        }
    }
    
}

extension MBBaseController {
    
    func showLoading() {
        MBAlerts.showLoading(on: self.view)
    }
    
    func hideLoading() {
        MBAlerts.hideLoading()
    }
    
    func showCenterToast(_ text: String, delay: TimeInterval = 2) {
        MBAlerts.showCenterToast(on: self.view, text: text, delay: delay)
    }
    
    func showToast(_ text: String, delay: TimeInterval = 2) {
        MBAlerts.showToast(on: self.view, text: text, delay: delay)
    }
    
    func showErrorMessage(_ text: String) {
        showCenterToast(text, delay: 5)
    }

}
