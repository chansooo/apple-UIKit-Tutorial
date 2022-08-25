//
//  TodayError.swift
//  Today
//
//  Created by Gordon Choi on 2022/08/26.
//

import Foundation

enum TodayError: LocalizedError {
    case failedReadingReminders
    
    var errorDescription: String? {
        switch self {
        case .failedReadingReminders:
            return NSLocalizedString("Falied to read reminders.", comment: "failed reading reminders error")
        }
    }
}
