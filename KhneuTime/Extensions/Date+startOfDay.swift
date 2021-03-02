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
}
