//
//  AppDelegate.swift
//  mab
//
//  Created by Shuo Wang on 24/5/20.
//  Copyright © 2020 Shuo Wang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    lazy var mainVC: MBMainTabbarController = {
        return MBMainTabbarController.instanceFromStoryboard(named: MBStoryboard.main)
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setup()
        return true
    }


}

extension AppDelegate {
    
    /// init
    private func setup() {
        // 加载空白跟控制器，处理预加载逻辑
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootVC = MBRootController.instanceFromStoryboard(named: MBStoryboard.main)
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
    }
    
    /// 切换到用户登录注册页面
    func switchToSign() {
        let signNav = MBSignNavigationController.instanceFromStoryboard(named: MBStoryboard.sign)
        self.window?.rootViewController = signNav
    }
    
    /// 切换到app主页面
    func switchToMainTab() {
        self.window?.rootViewController = mainVC
    }
    
}

