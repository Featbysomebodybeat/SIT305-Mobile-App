//
//  NotificationExtension.swift
//  EHealthHanAn
//
//  Created by Shuo Wang on 24/5/20.
//  Copyright © 2020 Shuo Wang. All rights reserved.
//

import Foundation

// MARK: - custom notification
public enum MBNotifationName: String {
    // MARK: custom notification name
    /// login success
    case login = "NotifationName.sh.login"
    /// log out
    case logout = "NotifationName.sh.logout"
    ///referesh user centre
    case userCenter_refresh = "NotifationName.sh.userCenter_refresh"
    /// chose tabbar
    case rootTabSelect = "NotifationName.sh.rootTabSelect"
    /// refresh
    case ztRefresh = "ztRefresh"
    //kit
    case zskRefresh = "zskRefresh"
    //lecture
    case lectureRefresh = "lectureRefresh"
    
    // MARK: system notification name
    var notificationName: Notification.Name {
        return Notification.Name(rawValue: self.rawValue)
    }
}

/// extension notification func
extension NotificationCenter {
    /// send notification
    open func sh_post(notifation name: MBNotifationName, object: Any? = nil, userInfo: [AnyHashable : Any]? = nil) {
        NotificationCenter.default.post(name: name.notificationName, object: object, userInfo: userInfo)
    }
    
    /* add listener */
    open func sh_add(observer: Any, selector: Selector, customName: MBNotifationName, object: Any? = nil) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: customName.notificationName, object: object)
    }
    
}
