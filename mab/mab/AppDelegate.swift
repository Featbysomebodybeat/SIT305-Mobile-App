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
    
    /// initial
    private func setup() {
        // load
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootVC = MBRootController.instanceFromStoryboard(named: MBStoryboard.main)
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
    }
    
    /// switch to sign
    func switchToSign() {
        let signNav = MBSignNavigationController.instanceFromStoryboard(named: MBStoryboard.sign)
        self.window?.rootViewController = signNav
    }
    
    /// switch to main
    func switchToMainTab() {
        self.window?.rootViewController = mainVC
    }
    
}

