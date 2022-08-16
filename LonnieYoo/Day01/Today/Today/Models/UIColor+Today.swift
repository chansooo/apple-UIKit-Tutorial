//
//  UIColor+Today.swift
//  Today
//
//  Created by ByeongJu Yu on 2022/08/16.
//

import UIKit

extension UIColor {
    static var todayListCellBackground: UIColor {
        UIColor(named: "TodayListCellBackground") ?? .secondarySystemBackground
    }
    
    static var todayListCellDoneButtonTint: UIColor {
        UIColor(named: "TodayListCellDoneButtonTint") ?? .tintColor
    }
    
    static var todayPrimaryTint: UIColor {
        UIColor(named: "TodayPrimaryTint") ?? .tintColor
    }
}
