//
//  MBDateManager.swift
//  mab
//
//  Created by Shuo Wang on 2/6/20.
//  Copyright © 2020 Shuo Wang. All rights reserved.
//

import UIKit
import SwiftDate

/// data management
class MBDateManager: NSObject {
    
    /// get date data
    static func getDatesAfterToday(for days: Int, includeToday flag: Bool = true) -> Array<Date> {
        return getDates(after: Date(), for: days, includeTargetDay: flag)
    }
    
    /// get dates
    static func getDates(after startDate: Date, for days: Int, includeTargetDay flag: Bool = true) -> Array<Date> {
        var tmpDates = Array<Date>()
        for i in 0..<days {
            let date = startDate + i.days
            tmpDates.append(date)
        }
        return tmpDates
    }
    
    /// get the next week dates
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
    
    /// get started date of the week
    static func getStartDateOfThisWeek() -> Date {
        return getStartDateOf(Date())
    }
    
    /// get the end date of the week
    static func getEndDateOfThisWeek() -> Date {
        return getEndDateOf(Date())
    }
    
    /// get a dat
    static func getStartDateOf(_ date: Date) -> Date {
        return date.dateAt(.startOfWeek)
    }
    
    /// get end date
    static func getEndDateOf(_ date: Date) -> Date {
        return getStartDateOf(date) + 6.days
    }
    
}
