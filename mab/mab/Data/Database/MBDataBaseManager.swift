//
//  MBDataBaseManager.swift
//  mab
//
//  Created by Shuo Wang on 1/6/20.
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
            
            let registers = db.executeUpdate("CREATE TABLE IF NOT EXISTS registers (userName TEXT NOT NULL, userPhone TEXT NOT NULL, hosName TEXT NOT NULL, hosCode TEXT NOT NULL, docName TEXT NOT NULL, date TEXT NOT NULL, category TEXT NOT NULL)", withArgumentsIn: [])
            
            if !users || !hospitals || !schedules || !news || !registers {
                rollback.pointee = true
                completion?(false)
                return
            }
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
