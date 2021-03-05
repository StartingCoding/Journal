//
//  TodayPage.swift
//  journal
//
//  Created by Loris on 12/17/20.
//

// https://matteomanferdini.com/codable/

import Foundation
import SwiftDate

class CalendarPage: ObservableObject {
    // MARK: - Model
    @Published private var days: [DayModel]
    var calendarContent: [CalendarModel]
    
    let monthsString = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    init() {
        var months = [CalendarModel]()
        
        // Making months for years
        for month in 0...11 {
            // Making days based on months
            let actualYearLoopingMonths = Date {
                $0.month = month + 1
            }
            
            var days = [CalendarModel]()
            for day in 1...actualYearLoopingMonths!.monthDays {
                let calendarModel = CalendarModel(name: "\(day)")
                days.append(calendarModel)
                
                // Add day for leap year
                if month == 1 && day == actualYearLoopingMonths!.monthDays {
                    let calendarModel = CalendarModel(name: String(day + 1))
                    days.append(calendarModel)
                }
            }
            
            // Making months with days
            let calendarModelForMonths = CalendarModel(name: monthsString[month], subCalendarModel: days)
            months.append(calendarModelForMonths)
        }
        
        var content = [String]()
        
        // Making years for the calendarContent
        for yearIndex in 0...4 {
            // Make content of a day based on years
            content.append("Text \(yearIndex)")
        }
        
        calendarContent = months
        
        // Calculate how many days are in a years from the open of the journal
        var daysInOneYear = 0
        for month in 0...11 {
            let monthDate = DateInRegion(year: Date().year, month: 1, day: 1) + month.months
            daysInOneYear += monthDate.monthDays
        }
        
        // Making day model for all of the days in the 12 months of a year
        let dayModel = DayModel(content: content)
        days = Array(repeating: dayModel, count: daysInOneYear)
    }
    
    // MARK: - Access to the Model
    var years: [String] {
        var allYears = [String]()
        for yearIterator in 0..<days[0].content.count {
            allYears.append(String(Date().year + yearIterator))
        }
        return allYears
    }
    
    var texts: [String] {
        get {
            days[indexForTexts].content
        }
        set {
            days[indexForTexts].content = newValue
        }
    }
    
    var indexForTexts = 0
    
    var month: String {
        let month = Date().month
        return monthsString[month]
    }
    
    // MARK: - Intent
    func makeIndexOutFor(date: String) -> Int {
        // Understand dateString
        let dateComponents = date.components(separatedBy: " ")
        let monthInt = monthsString.firstIndex(of: dateComponents[0])! + 1
        let dayInt = Int(dateComponents[1]) ?? 0
        
        // loop over til the day of the string creating index
        var index = 0
        for month in 1...monthInt {
            let monthDate = Date(year: Date().year, month: month, day: 1, hour: 0, minute: 0)
            
            if month == monthInt {
                index += dayInt
            } else {
                index += monthDate.monthDays
            }
        }
        return index - 1
    }
}
