//
//  Date+Today.swift
//  preview
//
//  Created by kimchansoo on 2022/08/17.
//

import Foundation

extension Date {
    var dayAndTimeText: String {
        let timeText = formatted(date: .omitted, time: .shortened)
        if Locale.current.calendar.isDateInToday(self){
            let timeFormat = NSLocalizedString("Today at %@", comment: "Today at time format string")
            return String(format: timeFormat, timeText)
        }
        else {
            let dateText = formatted(.dateTime.month(.abbreviated).day())
            let dateAndTimeFormat = NSLocalizedString("%@ at %@", comment: "Date and time format string")
            return String(format: dateAndTimeFormat, dateText, timeText)
        }
    }
    
    var datText: String {
        if Locale.current.calendar.isDateInToday(self){
            return NSLocalizedString("Today", comment: "Todat due date description")
        }
        else{
            return formatted(.dateTime.month().day().weekday(.wide))
        }
    }
}
