//
//  MBApplication.swift
//  mab
//
//  Created by Shuo Wang on 2020/6/2.
//  Copyright © 2020 Shuo Wang. All rights reserved.
//

import UIKit

struct MBApplication {
    
    /// AppDelegate
    static var appDelegate: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    // MARK: - App info
    /// dsplay name
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

// MARK: - app basic configs
extension MBApplication {

    // MARK: - switch root controller
    /// switchToMain
    static func switchToMain() {
        appDelegate?.switchToMainTab()
    }
    
    /// switchToUserSign
    static func switchToUserSign() {
        appDelegate?.switchToSign()
    }
    
}
