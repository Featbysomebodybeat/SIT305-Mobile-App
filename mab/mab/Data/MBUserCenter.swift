//
//  MBUserCenter.swift
//  mab
//
//  Created by Shuo Wang on 2/6/20.
//  Copyright © 2020 Shuo Wang. All rights reserved.
//

import UIKit

class MBUserCenter {
    
    static let shared = MBUserCenter()
    
    private init() {}
    
    // MARK: - login info
    /// login flag
    var isSignedIn: Bool {
        return userSignInfo != nil
    }
    
    /// user name
    var userName: String {
        return userSignInfo?.name ?? ""
    }
    
    /// user phone
    var userPhone: String {
        return userSignInfo?.phone ?? ""
    }

    /// user login info
    var userSignInfo: UserInfo? {
        set {
            let dic = newValue?.toJSON()
            MBUserDefault.set(dic: dic, for: .userSignInfo)
        }
        get {
            if let dic = MBUserDefault.getDic(with: .userSignInfo) {
                return UserInfo.deserialize(from: dic)
            }
            return nil
        }
    }
    
}

// MARK: - Query database
extension MBUserCenter {
    
    func logout() {
        userSignInfo = nil
        MBApplication.switchToUserSign()
    }
    
    /// distory account info
    func distoryAccount(_ completion: ((Result<UserInfo, SQLError>)->Void)?) {
        guard let user = userSignInfo else { DPrint("Empty user info"); return }
        UserInfoTable.delete(user) { (success) in
            if success {
                completion?(.success(user))
            }else {
                completion?(.failure(.sql))
            }
        }
    }
    
    /// sign up
    func signUp(_ user: UserInfo, completion: ((Result<UserInfo, SQLError>)->Void)?) {
        
//        UserInfoTable.judge(by: user.phone) { [weak self] (esist) in
//            if esist {
//                completion?(.failure(.userExist))
//            }else {
//                self?.save(user: user, completion: completion)
//            }
//        }
        UserInfoTable.query(by: user.phone) { [weak self] (users) in
            if users.first != nil {
                completion?(.failure(.userExist))
            }else {
                self?.save(user: user, completion: completion)
            }
        }
        
    }
    
    /// login
    func login(phone: String, pwd: String, completion: ((Result<UserInfo, SQLError>)->Void)?) {
        DPrint("Login info: {phone: \(phone), pwd: \(pwd)}")
        
        UserInfoTable.query(by: phone) { [weak self] (users) in
            if let user = users.first {
                if user.phone == phone {
                    if user.password == pwd {
                        // save login info
                        self?.userSignInfo = user
                        completion?(.success(user))
                    }else {
                        completion?(.failure(.wrongPwd))
                    }
                }else {
                    completion?(.failure(.unknown))
                }
            }else {
                completion?(.failure(.noUser))
            }
        }
    }
    
    /// save user to database
    private func save(user: UserInfo, completion: ((Result<UserInfo, SQLError>)->Void)?) {
        UserInfoTable.insert(user) { (success) in
            if success {
                completion?(.success(user))
            }else {
                completion?(.failure(.sql))
            }
        }
    }
    
}




