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
    public func weekDayEnglishName(preFix: String = "week") -> String {
        switch self.weekday {
        case 1:
            return preFix + "Sunday"
        case 2:
            return preFix + "Monday"
        case 3:
            return preFix + "Tuesday"
        case 4:
            return preFix + "Wednesday"
        case 5:
            return preFix + "Thursday"
        case 6:
            return preFix + "Friday"
        case 7:
            return preFix + "Saturaday"
        default:
            return "000"
        }
    }
    
    /// check same day
    public func isTheSameDay(compareTo date: Date) -> Bool {
        return self.compare(toDate: date, granularity: .day) == .orderedSame
    }
    
}
