//
//  MBDateManager.swift
//  mab
//
//  Created by Shuo Wang on 2020/6/2.
//  Copyright © 2020 Shuo Wang. All rights reserved.
//

import UIKit
import SwiftDate

/// 日期管理类(基于SwiftDate)
class MBDateManager: NSObject {
    
    /// 获取今天以后后的多少天的日期数组
    static func getDatesAfterToday(for days: Int, includeToday flag: Bool = true) -> Array<Date> {
        return getDates(after: Date(), for: days, includeTargetDay: flag)
    }
    
    /// 获取指定日期后的多少天的日期数组
    static func getDates(after startDate: Date, for days: Int, includeTargetDay flag: Bool = true) -> Array<Date> {
        var tmpDates = Array<Date>()
        for i in 0..<days {
            let date = startDate + i.days
            tmpDates.append(date)
        }
        return tmpDates
    }
    
    /// 获取今天所在的一周的日期
    static func getCurrentWeekDates() -> Array<Date> {
        var tmpDates = Array<Date>()
        let startDate = getStartDateOfThisWeek()
        tmpDates.append(startDate)
        for i in 1..<7 {
            let date = startDate + i.days
            tmpDates.append(date)
        }
        return tmpDates
    }
    
    /// 获取本周的第一天(周日)
    static func getStartDateOfThisWeek() -> Date {
        return getStartDateOf(Date())
    }
    
    /// 获取本周的最后一天(周六)
    static func getEndDateOfThisWeek() -> Date {
        return getEndDateOf(Date())
    }
    
    /// 获取某一天所在星期的第一天(周日)
    static func getStartDateOf(_ date: Date) -> Date {
        return date.dateAt(.startOfWeek)
    }
    
    /// 获取某一天所在星期的最后一天(周六)
    static func getEndDateOf(_ date: Date) -> Date {
        return getStartDateOf(date) + 6.days
    }
    
}
