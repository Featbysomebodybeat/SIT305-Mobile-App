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

    private static func createDatabaseQueue() -> FMDatabaseQueue? {
        
        
        
        guard let dbPath = Bundle.main.path(forResource: "mab_database", ofType: "sqlite") else {DPrint("Get db path faild!");return nil}
        
        return FMDatabaseQueue(path: dbPath)
    }
    
}

extension MBDatabaseManager {
    
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
