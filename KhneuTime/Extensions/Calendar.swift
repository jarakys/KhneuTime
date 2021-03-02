//
//  Calendar.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 03.03.2021.
//

import Foundation

extension Calendar {
    static let iso8601UTC: Calendar = {
        var calendar = Calendar(identifier: .iso8601)
        calendar.timeZone = TimeZone(identifier: "UTC")!
        calendar.locale = Locale(identifier: "en_US_POSIX")
        return calendar
    }()
}

extension Date {
    var time: String {
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    
    var hour: Int {
        let hour = Calendar.current.component(.hour, from: self)
        return hour
    }
    
    var startOfMonth: Date {
        let components = Calendar.iso8601UTC.dateComponents([.year, .month], from: self)
        return Calendar.iso8601UTC.date(from: components)!
    }
    
    var mondayOfTheSameWeek: Date {
        Calendar.iso8601UTC.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: self).date!
    }
    
    var numberOfDay: Int {
        let myComponents = Calendar.iso8601UTC.dateComponents([.weekday], from: self)
        return myComponents.weekday!
    }
}
