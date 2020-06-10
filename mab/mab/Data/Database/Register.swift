//
//  Register.swift
//  mab
//
//  Created by zhengheng on 2020/6/10.
//  Copyright © 2020 Shuo Wang. All rights reserved.
//

import Foundation
import HandyJSON
import FMDB

struct Register: HandyJSON {
    var userName = ""
    var userPhone = ""
//    var medicare = ""
    
    var hosName = ""
    var hosCode = ""
    var docName = ""
    
    var date = ""
    var category = ""
    
}

struct RegisterTable {
    
    static func getRegisters(phone: String, completion: ((_ users: [Register]) -> Void)?) {
        let sql = "select * from registers where newsId=\(phone)"
        MBDatabaseManager.query(sql, params: nil) { (resultSet) in
            var tmp = [Register]()
            if let set = resultSet {
                while set.next() {
                    let userName = set.string(forColumn: "userName") ?? ""
                    let userPhone = set.string(forColumn: "userPhone") ?? ""
//                    let medicare = set.string(forColumn: "medicare") ?? ""
                    let hosName = set.string(forColumn: "hosName") ?? ""
                    
                    let hosCode = set.string(forColumn: "hosCode") ?? ""
                    let docName = set.string(forColumn: "docName") ?? ""
                    let date = set.string(forColumn: "date") ?? ""
                    let category = set.string(forColumn: "category") ?? ""
                    
                    let register = Register(userName: userName, userPhone: userPhone, hosName: hosName, hosCode: hosCode, docName: docName, date: date, category: category)
                    tmp.append(register)
                }
                set.close()
                completion?(tmp)
            }
        }
    }
    
    static func insert(_ register: Register, completion: ((_ success: Bool) -> Void)?) {
        let sql = "INSERT INTO registers (userName, userPhone, hosName, hosCode, docName, date, category) VALUES (:userName, :userPhone, :hosName, :hosCode, :docName, :date, :category);"
        if let dic = register.toJSON() {
            MBDatabaseManager.update(sql, params: dic, completion: completion)
        }
    }
        
}
