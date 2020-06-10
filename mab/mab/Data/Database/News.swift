//
//  News.swift
//  mab
//
//  Created by Shuo Wang on 9/6/20.
//  Copyright © 2020 Shuo Wang. All rights reserved.
//

import UIKit
import HandyJSON
import FMDB

struct News: HandyJSON {
    var newsId = ""
    var date = ""
    var title = ""
    var channel = ""
}

struct NewsTable {
    
    static func getNews(newsId: String = "", completion: ((_ users: [News]) -> Void)?) {
        let sql = newsId.isEmpty ? "select * from news;" : "select * from news where newsId=\(newsId)"
        MBDatabaseManager.query(sql, params: nil) { (resultSet) in
            var tmp = [News]()
            if let set = resultSet {
                while set.next() {
                    let newsId = set.string(forColumn: "newsId") ?? ""
                    let date = set.string(forColumn: "date") ?? ""
                    let title = set.string(forColumn: "title") ?? ""
                    let channel = set.string(forColumn: "channel") ?? ""
                    let news = News(newsId: newsId, date: date, title: title, channel: channel)
                    tmp.append(news)
                }
                set.close()
                completion?(tmp)
            }
        }
    }
    
}
