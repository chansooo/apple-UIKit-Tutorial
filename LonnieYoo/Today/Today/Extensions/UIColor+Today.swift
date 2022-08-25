//
//  UIColor+Today.swift
//  Today
//
//  Created by ByeongJu Yu on 2022/08/16.
//

import UIKit

extension UIColor {
    static var todayDetailCellTint: UIColor {
        UIColor(named: "TodayDetailCellTint") ?? .clear
    }
    
    static var todayListCellBackground: UIColor {
        UIColor(named: "TodayListCellBackground") ?? .secondarySystemBackground
    }
    
    static var todayListCellDoneButtonTint: UIColor {
        UIColor(named: "TodayListCellDoneButtonTint") ?? .clear
    }
    
    static var todayGradientAllBegin: UIColor {
        UIColor(named: "TodayGradientAllBegin") ?? .systemFill
    }
    
    static var todayGradientAllEnd: UIColor {
        UIColor(named: "TodayGradientAllEnd") ?? .quaternarySystemFill
    }
    
    static var todayGradientFutureBegin: UIColor {
            UIColor(named: "TodayGradientFutureBegin") ?? .systemFill
    }
    
    static var todayGradientFutureEnd: UIColor {
            UIColor(named: "TodayGradientFutureEnd") ?? .quaternarySystemFill
    }
    
    static var todayGradientTodayBegin: UIColor {
            UIColor(named: "TodayGradientTodayBegin") ?? .systemFill
    }
    
    static var todayGradientTodayEnd: UIColor {
            UIColor(named: "TodayGradientTodayEnd") ?? .quaternarySystemFill
    }
    
    static var todayNavigationBackground: UIColor {
        UIColor(named: "TodayNavigationBackground") ?? .secondarySystemBackground
    }
    
    static var todayPrimaryTint: UIColor {
        UIColor(named: "TodayPrimaryTint") ?? .clear
    }
    
    static var todayProgressLowerBackground: UIColor {
        UIColor(named: "TodayProgressLowerBackground") ?? .systemGray
    }
    
    static var todayProgressUpperBackground: UIColor {
        UIColor(named: "TodayProgressUpperBackground") ?? .systemGray6
    }
}
