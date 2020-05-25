//
//  MBApp.swift
//  mab
//
//  Created by Shuo Wang on 24/5/20.
//  Copyright © 2020 Shuo Wang. All rights reserved.
//

import UIKit

/// App 配置
class SHApp {
    
    static let shared = SHApp()
    
    private init() {}
    
    /// AppDelegate
//    static var appDelegate: AppDelegate? {
//        return UIApplication.shared.delegate as? AppDelegate
//    }
    
    // MARK: - app basic info
    /// App 名称
    static var displayName: String {
        if let infoDic = Bundle.main.infoDictionary,
            let name = infoDic["CFBundleDisplayName"] as? String
        {
            return name
        }
        return ""
    }
    
    /// App version number
    static var version: String {
        if let infoDic = Bundle.main.infoDictionary,
            let version = infoDic["CFBundleShortVersionString"] as? String
        {
            return version
        }
        return ""
    }
    
    /// App build number
    static var buildNumber: String {
        if let infoDic = Bundle.main.infoDictionary,
            let build = infoDic["CFBundleVersion"] as? String
        {
            return build
        }
        return ""
    }
    
}

// MARK: - app baisc setting
extension SHApp {
    /// first time launch app
    static var isfirstLaunch: Bool {
        set {
            MBUserDefault.setBool(value: newValue, for: .firstGuide)
        }
        get {
            return MBUserDefault.getBool(with: .firstGuide)
        }
    }
    /// show advertisement
    static var isShowAdvertisement: Bool {
        set {
            MBUserDefault.setBool(value: newValue, for: .adPromote)
        }
        get {
            return MBUserDefault.getBool(with: .adPromote)
        }
    }

    // MARK: - switch controller
//    static func switchToFirstGuide() {
//        appDelegate?.switchToFirstGuide()
//    }
//    /// switch to homepage
//    static func switchToMain() {
//        appDelegate?.switchToMainTab()
//    }
//
//    /// switch to user page
//    static func switchToUserSign() {
//        appDelegate?.switchToSign()
//    }
//
//    /// switch to advertisement page
//    static func switchToAdvertisement() {
//        appDelegate?.switchToAdPromote()
//    }
    
}
