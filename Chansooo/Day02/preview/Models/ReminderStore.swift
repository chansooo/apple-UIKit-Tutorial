//
//  ReminderStore.swift
//  preview
//
//  Created by kimchansoo on 2022/08/23.
//

import Foundation
import EventKit

class ReminderStore {
    static let shared = ReminderStore()
    
    private let ekStore = EKEventStore()
    
}
