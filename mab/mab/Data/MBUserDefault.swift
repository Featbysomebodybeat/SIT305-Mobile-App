//
//  HAUserDefaultManager.swift
//  EHealthHanAn
//
//  Created by Shuo Wang on 24/5/20.
//  Copyright © 2020 Shuo Wang. All rights reserved.
//
//  use for save/withdraw userDefault

import UIKit

/// for save key
enum MBUserDefaultKey: String {
    /// login info
    case userSignInfo = "userSignInfo"
    /// if first time loeading
    case firstGuide = "firstGuide"
    /// logged in
    case signedIn = "signedIn"
    /// promote button
    case adPromote = "adPromote"
    
    case searchHistory = "searchHistory"
    //user icon
    case headProfile = "headProfile"
}

/// UserDefault management
struct MBUserDefault {
    /// save bool
    static func setBool(value: Bool, for key: MBUserDefaultKey) {
        set(value, forKey: key.rawValue)
    }
    
    /// get bool
    static func getBool(with key: MBUserDefaultKey) -> Bool {
        return UserDefaults.standard.bool(forKey: key.rawValue)
    }
    
    /// save string data
    static func setString(value: String?, for key: MBUserDefaultKey) {
        guard let v = value else {
            set(value, forKey: key.rawValue)
            return
        }
        // TODO: AES crypt
        let encrypted = v.toAES()
        set(encrypted, forKey: key.rawValue)
    }
    
    /// get string data
    static func getString(with key: MBUserDefaultKey) -> String? {
        let udString = UserDefaults.standard.string(forKey: key.rawValue)
        // TODO: encrypt AES
        let decrypted = udString?.decodeAES()
        return decrypted
    }
    
    /// save int data
    static func set(intValue: Int?, for key: MBUserDefaultKey) {
        set(intValue, forKey: key.rawValue)
    }
    
    /// save int data
    static func getInt(with key: MBUserDefaultKey) -> Int? {
        return UserDefaults.standard.object(forKey: key.rawValue) as? Int
    }
    
    /// save dictionary
    static func set(dic value: Dictionary<String, Any>?, for key: MBUserDefaultKey) {
        if let val = value, val.count <= 0 {
            set(nil, forKey: key.rawValue)
        }else {
            set(value, forKey: key.rawValue)
        }
    }
    
    /// load dictionary
    static func getDic(with key: MBUserDefaultKey) -> Dictionary<String, Any>? {
        return UserDefaults.standard.object(forKey: key.rawValue) as? Dictionary<String, Any>
    }
    
    /// save array
    static func set(arr value: Array<String>?, for key: MBUserDefaultKey) {
        if let val = value, val.count <= 0 {
            set(nil, forKey: key.rawValue)
        }else {
            set(value, forKey: key.rawValue)
        }
//        set(value, forKey: key.rawValue)
    }
    
    /// load save data
    static func getArr(with key: MBUserDefaultKey) -> Array<String>? {
        return UserDefaults.standard.object(forKey: key.rawValue) as? Array<String>
    }
    
    /// save NSCoding data
    static func set(data obj: NSCoding, for key: MBUserDefaultKey) {
        let encodedObj = NSKeyedArchiver.archivedData(withRootObject: obj)
        set(encodedObj, forKey: key.rawValue)
    }
    
    /// load NSCoding data
    static func get(with key: MBUserDefaultKey) -> Any? {
        guard let decodedData = UserDefaults.standard.object(forKey: key.rawValue) as? Data else {
            return nil
        }
        return NSKeyedUnarchiver.unarchiveObject(with: decodedData)
    }
    
    /// clear data
    static func clearDatas() {
        UserDefaults.resetStandardUserDefaults()
        UserDefaults.standard.synchronize()
    }
    
    /// save value
    private static func set(_ value: Any?, forKey key: String) {
        let userDefault = UserDefaults.standard
        UserDefaults.standard.set(value, forKey: key)
        userDefault.synchronize()
    }
    
}
