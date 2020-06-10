//
//  Hospitals.swift
//  mab
//
//  Created by Shuo Wang on 9/6/20.
//  Copyright © 2020 Shuo Wang. All rights reserved.
//

import UIKit
import HandyJSON
import FMDB

struct Hospital: HandyJSON {
    var hosName = ""
    var hosCode = ""
    var address = ""
    var tel = ""
}

struct HospitalTable {
    
    static func getHospitals(_ completion: ((_ hospitals: [Hospital]) -> Void)?) {
        let sql = "select * from Hospitals"
        MBDatabaseManager.query(sql, params: nil) { (resultSet) in
            var tmp = [Hospital]()
            if let set = resultSet {
                while set.next() {
                    let hosName = set.string(forColumn: "hosName") ?? ""
                    let hosCode = set.string(forColumn: "hosCode") ?? ""
                    let address = set.string(forColumn: "address") ?? ""
                    let tel = set.string(forColumn: "tel") ?? ""
                    let hos = Hospital(hosName: hosName, hosCode: hosCode, address: address, tel: tel)
                    tmp.append(hos)
                }
                set.close()
                completion?(tmp)
            }
        }
    }

}
