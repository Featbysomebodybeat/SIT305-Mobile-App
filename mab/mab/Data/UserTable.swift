//
//  UserInfo.swift
//  mab
//
//  Created by Shuo Wang on 2020/6/2.
//  Copyright © 2020 Shuo Wang. All rights reserved.
//

import Foundation
import FMDB
import HandyJSON

struct UserInfo: HandyJSON {
    var name = ""
    var pwd = ""
    var phone = ""
    var idNo = ""
    var medicare = ""
    var icon = ""
    var birthday = ""
}

struct UserInfoTable {
    
    static func judge(by phone: String, completion: ((_ exist: Bool) -> Void)?) {
        
        let sql = "SELECT COUNT(name) AS countNum FROM USER_INFO WHERE phone=\(phone)"
        
        MBDatabaseManager.query(sql, params: nil) { (resultSet) in
            if let set = resultSet {
                while set.next() {
                    let count = set.int(forColumn: "countNum")
                    completion?(count > 0)
                }
            }
        }
    }
    
    static func query(by phone: String, completion: ((_ users: [UserInfo]) -> Void)?) {
        
        let sql = "select * from USER_INFO where phone=\(phone)"
        MBDatabaseManager.query(sql, params: nil) { (resultSet) in
            var tmp = [UserInfo]()
            if let set = resultSet {
                while set.next() {
                    let name = set.string(forColumn: "name") ?? ""
                    let pwd = set.string(forColumn: "pwd") ?? ""
                    let phone = set.string(forColumn: "phone") ?? ""
                    let idNo = set.string(forColumn: "idNo") ?? ""
                    let medicare = set.string(forColumn: "medicare") ?? ""
                    let icon = set.string(forColumn: "icon") ?? ""
                    let birthday = set.string(forColumn: "birthday") ?? ""
                    let user = UserInfo(name: name, pwd: pwd, phone: phone, idNo: idNo, medicare: medicare, icon: icon, birthday: birthday)
                    tmp.append(user)
                }
                set.close()
                completion?(tmp)
            }
        }
        
    }
    
    static func insert(_ user: UserInfo, completion: ((_ success: Bool) -> Void)?) {
        let sql = "INSERT INTO USER_INFO (idNo, name, birthday, phone, icon, pwd, medicare) VALUES (?, ?, ?, ?, ?, ?, ?)"
        if let dic = user.toJSON() {
            MBDatabaseManager.update(sql, params: dic, completion: completion)
        }
    }
    
    static func update(_ user: UserInfo, completion: ((_ success: Bool) -> Void)?) {
        let sql = "update USER_INFO set name=?, pwd=?, idNo=?, medicare=?, icon=?, birthday=? where phone=?"
        if let dic = user.toJSON() {
            MBDatabaseManager.update(sql, params: dic, completion: completion)
        }
        
    }
    
    static func delete(_ user: UserInfo, completion: ((_ success: Bool) -> Void)?) {
        let sql = "delete from USER_INFO where phone=?"
        
        if let dic = user.toJSON() {
            MBDatabaseManager.update(sql, params: dic, completion: completion)
        }
    }
    
}
