//
//  Date+Today.swift
//  Today
//
//  Created by ByeongJu Yu on 2022/08/16.
//

import Foundation

// TODO: iOS13에서도 동작하도록 수정 해보자!
extension Date {
    var dayAndTimeText: String {
        let timeText = convertTimeToString(with: "ah:m")
        if Locale.current.calendar.isDateInToday(self) {
            let timeFormat = NSLocalizedString("Today at %@", comment: "Today at time format string")
            return String(format: timeFormat, timeText)
        } else {
            let dateText = convertDateToString(with: "MMMdd")
            let dateAndTimeFormat = NSLocalizedString("%@ at %@", comment: "Date and time format string")
            return String(format: dateAndTimeFormat, dateText, timeText)
        }
    }
    
    var dayText: String {
        if Locale.current.calendar.isDateInToday(self) {
            return NSLocalizedString("Today", comment: "Today due date description")
        } else {
            return convertDateToString(with: "MMMddEEEE")
        }
    }
    
    func convertDateToString(with format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.setLocalizedDateFormatFromTemplate(format)
        return dateFormatter.string(from: self)
    }
    
    func convertTimeToString(with format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .full
        dateFormatter.setLocalizedDateFormatFromTemplate(format)
        return dateFormatter.string(from: self)
    }
}
