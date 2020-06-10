//
//  Schedules.swift
//  mab
//
//  Created by zhengheng on 2020/6/9.
//  Copyright © 2020 Shuo Wang. All rights reserved.
//

import UIKit
import HandyJSON
import FMDB

struct Schedule: HandyJSON {
    var date = ""
    var hosCode = ""
    var docName = ""
    var depCode = ""
}

struct SchedulesTable {
    
    static func getSchedules(date: String = "", completion: ((_ users: [Schedule]) -> Void)?) {
        let sql = date.isEmpty ? "select * from schedules" : "select * from schedules where date=\(date)"
        MBDatabaseManager.query(sql, params: nil) { (resultSet) in
            var tmp = [Schedule]()
            if let set = resultSet {
                while set.next() {
                    let date = set.string(forColumn: "date") ?? ""
                    let hosCode = set.string(forColumn: "hosCode") ?? ""
                    let docName = set.string(forColumn: "docName") ?? ""
                    let depCode = set.string(forColumn: "depCode") ?? ""
                    let schedule = Schedule(date: date, hosCode: hosCode, docName: docName, depCode: depCode)
                    tmp.append(schedule)
                }
                set.close()
                completion?(tmp)
            }
        }
    }
    
}
