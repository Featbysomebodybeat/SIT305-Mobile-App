//
//  MBAssets.swift
//  mab
//
//  Created by Shuo Wang on 2020/6/2.
//  Copyright © 2020 Shuo Wang. All rights reserved.
//

import UIKit

// MARK: - 颜色
struct MBColor {
    private init() {}
    static let mainTint = UIColor(hex: "#8EC63F")
    static let white = UIColor(hex: "#FFFFFF")
    
    static let textLight = UIColor(hex: "#AAAAAA")
    static let textDark = UIColor(hex: "#474E50")
    
    static let background = UIColor(hex: "#E9ECE3")
    static let grayBackground = UIColor(hex: "#FAFAFA")
    
}

// MARK: - 字号
struct MBFont {
    enum Sys: CGFloat {
        case micro = 10
        case small = 12
        case thin = 14
        case normal = 16
        case medium = 18
        case large = 20
        
        var font: UIFont {
            return UIFont.systemFont(ofSize: self.rawValue)
        }
    }
}

// MARK: - 图片
struct MBImage {
    
    enum Bar: String {
        case bgWhite = "bar_bg_white"
        case naviBack = "navi_back"
        case background = "bar_background"
        case shadow = "bar_shadow"
        
        /// 获取对应的图片
        var image: UIImage? { return UIImage(named: self.rawValue) }
    }
    
    enum Common: String {
        case iconHolder = "icon_holder"

        
        /// 获取对应的图片
        var image: UIImage? { return UIImage(named: self.rawValue) }
    }
    
    /// 空内容图片
    enum EmptyData: String {
        case noNetwork = "empty_no_network"

        
        /// 获取对应的图片
        var image: UIImage? { return UIImage(named: self.rawValue) }
    }
    
}

// MARK: - 资源路径
struct MBSourcePath {
    private init(){}
    /// loading图片
    static var loadingGif: String? {return Bundle.main.path(forResource: "local_loading", ofType: "gif")}
    static var refreshGif: String? {return Bundle.main.path(forResource: "local_fefresh", ofType: "gif")}
}

// MARK: - storyboard
struct MBStoryboard {
    private init(){}

    /// main
    static let main = "Main"
    /// register and login
    static let sign = "Sign"
    /// user center
    static let userCenter = "UserCenter"
    
}
