//
//  Date+startOfDay.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 02.03.2021.
//

import Foundation

extension Date {
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    func getDescription(by format: String) -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = format
        return dateFormatterPrint.string(from: self)
    }
    
    func addDay(value: Int) -> Self {
        return Calendar.current.date(byAdding: .day, value: value, to: self) ?? self
    }
    
    func addMonth(value: Int) -> Self {
        return Calendar.current.date(byAdding: .month, value: value, to: self) ?? self
    }
}
