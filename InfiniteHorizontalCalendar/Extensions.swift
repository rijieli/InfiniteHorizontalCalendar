//
//  Extensions.swift
//  InfiniteHorizontalCalendar
//
//  Created by 李日杰 on 2021/1/17.
//

import Foundation
import UIKit

extension Date {
    
    var yearAndMonthString: String {
        
        let year = self.todayDateComponents.year!
        let monthSymbol = Calendar.current.monthSymbols[todayDateComponents.month!-1]
        
        return String(year) + "  " + monthSymbol
    }
    
    var positionInCalendar: Int {
        let todayComponents = self.todayDateComponents
        return todayComponents.weekday! + (todayComponents.weekOfMonth!-1) * 7
    }
    
    var todayDateComponents: DateComponents {
        return Calendar.current.dateComponents([.year, .month, .day, .weekday, .weekOfMonth], from: self)
    }
    
    var dayOfMonth: Int {
        return self.todayDateComponents.day!
    }
    
    func addingDays(_ num: Int) -> Date {
        return self + TimeInterval(60 * 60 * 24 * num)
    }
    
    func addingMonths(_ num: Int) -> Date {
        return Calendar.current.date(byAdding: .month, value: num, to: self)!
    }
    
    func getCalendarMap() -> [Int: Date] {

        var calendarMap: [Int: Date] = [:]
        let position = self.positionInCalendar
        
        calendarMap[position] = self

        for i in 1..<position {
            calendarMap[position - i] = self.addingDays(-i)
        }

        for i in position+1...42 {
            calendarMap[i] = self.addingDays(i - position)
        }
        
        return calendarMap
    }
    
    func printCurrentMonthCalendar() {
        
        let dateTable = self.getCalendarMap()
        
        print("SUN MON TUE WED THU FRI SAT")
        for i in 1...42 {

            let dayString = String(format: "%3d", dateTable[i]!.dayOfMonth)
            
            if i % 7 != 0 {
                print(dayString + " ", terminator:"")
            } else {
                print(dayString)
            }
        }
    }
}

extension UIView {
    
    func addCustomConstraints(_ constraints: NSLayoutConstraint...) {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }
    
}
