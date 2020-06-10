//
//  DateExtension.swift
//  mab
//
//  Created by Shuo Wang on 24/5/20.
//  Copyright © 2020 Shuo Wang. All rights reserved.
//

import Foundation

// MARK: - class function
extension Date {
    
    /// get time
    static func getTimeIntervalStringSince1970() -> String {
        let time = Date().timeIntervalSince1970
        return String(format: "%ld", Int(time))
    }
    
}

// MARK: - sample function
extension Date {
    
    /// transfer
    public func toString(_ format: String) -> String {
        let formater = DateFormatter()
        formater.dateFormat = format
        return formater.string(from: self)
    }
    
    /// transfer
    public func weekDayEnglishName(preFix: String = "") -> String {
        switch self.weekday {
        case 1:
            return preFix + "Sun"
        case 2:
            return preFix + "Mon"
        case 3:
            return preFix + "Tue"
        case 4:
            return preFix + "Wed"
        case 5:
            return preFix + "Thu"
        case 6:
            return preFix + "Fri"
        case 7:
            return preFix + "Sat"
        default:
            return "000"
        }
    }
    
    /// check same day
    public func isTheSameDay(compareTo date: Date) -> Bool {
        return self.compare(toDate: date, granularity: .day) == .orderedSame
    }
    
}
