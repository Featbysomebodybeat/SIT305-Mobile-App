//
//  Schedules.swift
//  mab
//
//  Created by Shuo Wang on 9/6/20.
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
    
    static func getSchedules(hosCode: String, date: String = "", completion: ((_ users: [Schedule]) -> Void)?) {
        let sql = date.isEmpty ? "select * from schedules where hosCode=\(hosCode)" : "select * from schedules where hosCode=\(hosCode) and date=\(date)"
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
