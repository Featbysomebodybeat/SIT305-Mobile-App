//
//  UserInfo.swift
//  mab
//
//  Created by Shuo Wang on 9/6/20.
//  Copyright © 2020 Shuo Wang. All rights reserved.
//

import Foundation
import FMDB
import HandyJSON

struct UserInfo: HandyJSON {
    var name = ""
    var password = ""
    var phone = ""
    var medicare = ""
}

struct UserInfoTable {
    
    static func query(by phone: String, completion: ((_ users: [UserInfo]) -> Void)?) {
        
        let sql = "select * from users where phone=\(phone)"
        MBDatabaseManager.query(sql, params: nil) { (resultSet) in
            var tmp = [UserInfo]()
            if let set = resultSet {
                while set.next() {
                    let name = set.string(forColumn: "name") ?? ""
                    let pwd = set.string(forColumn: "password") ?? ""
                    let phone = set.string(forColumn: "phone") ?? ""
                    let medicare = set.string(forColumn: "medicare") ?? ""
                    let user = UserInfo(name: name, password: pwd, phone: phone, medicare: medicare)
                    tmp.append(user)
                }
                set.close()
                completion?(tmp)
            }
        }
        
    }
    
    static func insert(_ user: UserInfo, completion: ((_ success: Bool) -> Void)?) {
        let sql = "INSERT INTO users (name, phone, password, medicare) VALUES (:name, :phone, :password, :phone);"
        if let dic = user.toJSON() {
            MBDatabaseManager.update(sql, params: dic, completion: completion)
        }
    }
    
    static func update(_ user: UserInfo, completion: ((_ success: Bool) -> Void)?) {
        let sql = "update users set name=?, password=?, medicare=? where phone=?"
        if let dic = user.toJSON() {
            MBDatabaseManager.update(sql, params: dic, completion: completion)
        }
        
    }
    
    static func delete(_ user: UserInfo, completion: ((_ success: Bool) -> Void)?) {
        let sql = "delete from user_info where phone=?"
        
        if let dic = user.toJSON() {
            MBDatabaseManager.update(sql, params: dic, completion: completion)
        }
    }
    
}
