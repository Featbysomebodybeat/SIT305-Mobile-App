//
//  MBDataBaseManager.swift
//  mab
//
//  Created by Shuo Wang on 2020/6/1.
//  Copyright © 2020 Shuo Wang. All rights reserved.
//

import Foundation
import FMDB

enum SQLError: Error {
    
    case unknown, sql, userExist, noUser, wrongPwd
    
    var localizedDescription: String {
        switch self {
        case .userExist:
            return "The phone number is already signed up, please try to login"
        case .noUser:
            return "There is no user binding the phone number, please goto sign up"
        case .wrongPwd:
            return "Wrong password!"
        default:
            return "unknown error"
        }
    }
}

/// Database manager
class MBDatabaseManager {

    static func copyDbFileToSandbox() {
        guard let dbPath = Bundle.main.path(forResource: "mab_database", ofType: "db"),
            let docPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {DPrint("Get db path faild!");return}
        if !FileManager.default.fileExists(atPath: docPath+"/mab_database.db") {
            do {
                try FileManager.default.copyItem(atPath: dbPath, toPath: docPath+"/mab_database.db")
                DPrint("Copy DBFile succeed!")
            }catch {
                DPrint("Copy DBFile failed: \(error.localizedDescription)")
            }
        }else {
            DPrint("DBFile is exsit!")
        }
    }
    
    static func createDatabaseQueue() -> FMDatabaseQueue? {
        guard let dbPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {DPrint("Get db path faild!");return nil}
        let path = dbPath+"/mab_database.db"
        DPrint("User DB, path: " + path)
        return FMDatabaseQueue(path: path)
    }
    
}

extension MBDatabaseManager {
    
    static func createTables(_ completion: ((_ success: Bool)->Void)?) {
        guard let queue = createDatabaseQueue() else {
            return
        }

        queue.inTransaction { (db, rollback) in
            let users = db.executeUpdate("CREATE TABLE IF NOT EXISTS users (name TEXT NOT NULL, phone TEXT NOT NULL, password TEXT NOT NULL, medicare TEXT NOT NULL, desc TEXT)", withArgumentsIn: [])
            let hospitals = db.executeUpdate("CREATE TABLE IF NOT EXISTS hospitals (hosName TEXT NOT NULL, hosCode TEXT NOT NULL, address TEXT NOT NULL, tel TEXT NOT NULL, desc TEXT)", withArgumentsIn: [])
            let schedules = db.executeUpdate("CREATE TABLE IF NOT EXISTS schedules (date TEXT NOT NULL, hosCode TEXT NOT NULL, docName TEXT NOT NULL, depCode TEXT NOT NULL, desc TEXT)", withArgumentsIn: [])
            
            let news = db.executeUpdate("CREATE TABLE IF NOT EXISTS news (newsId TEXT NOT NULL, date TEXT NOT NULL, title TEXT NOT NULL, channel TEXT NOT NULL, desc TEXT)", withArgumentsIn: [])
            
            if !users || !hospitals || !schedules || !news {
                rollback.pointee = true
                completion?(false)
                return
            }
            
            // insert datas
//            db.executeUpdate("INSERT INTO users (name, phone, password, medicare) VALUES (?, ?, ?, ?);", withArgumentsIn: ["HENG Z", "13666666666", "123456", "NU03678930"])
//            db.executeUpdate("INSERT INTO hospitals (hosName, hosCode, address, tel) VALUES (?, ?, ?, ?);", withArgumentsIn: ["Tower Hospital", "03001", "L.A. Apple Street", "080-34567"])
//            db.executeUpdate("INSERT INTO schedules (date, hosCode, docName, depCode) VALUES (?, ?, ?, ?);", withArgumentsIn: ["2020-06-07", "03001", "SAN ZHANG", "as"])
            completion?(true)
            
        }
    }
    
    static func update(_ sql: String, params dic: [String: Any], completion: ((_ success: Bool)->Void)?) {
        guard let queue = createDatabaseQueue() else {
            return
        }
        
        queue.inDatabase { (db) in
            let success = db.executeUpdate(sql, withParameterDictionary: dic)
            DispatchQueue.main.async {
                completion?(success)
            }
        }
    }
        
    static func query(_ sql: String, params dic: [String: Any]? = nil, completion: ((_ resultSet: FMResultSet?)->Void)?) {
        
        guard let queue = createDatabaseQueue() else {
            return
        }
        
        queue.inDatabase { (db) in
            let set = db.executeQuery(sql, withParameterDictionary: dic)
            DispatchQueue.main.async {
                completion?(set)
            }
            
        }
        
    }
    
}
