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
    @Published private var dayContent: [DayModel]
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
            for day in 1..<actualYearLoopingMonths!.monthDays {
                let calendarModel = CalendarModel(name: "\(day)")
                days.append(calendarModel)
            }
            // Making months with days
            let calendarModelForMonths = CalendarModel(name: monthsString[month], subCalendarModel: days)
            months.append(calendarModelForMonths)
        }
        
        
        var years = [CalendarModel]()
        let actualYear = Date().year
        
        var content = [[String]]()
        
        // Making years for the calendarContent
        for yearIndex in 0...4 {
            // Make content of a day based on years
            content.append(["\(actualYear + yearIndex)", "Text \(yearIndex)"])
            
            // Make years with months and days
            let calendarModelForYears = CalendarModel(name: "\(actualYear + yearIndex)", subCalendarModel: months)
            years.append(calendarModelForYears)
        }
        
        calendarContent = years
        
        
        // Calculate how many days are in 5 years from the open of the journal
        var daysInFiveYears = 0
        for year in 0...4 {
            let startDate = DateInRegion(year: Date().year + year, month: 1, day: 1)
            
            for month in 0...11 {
                let monthDate = startDate + month.months
                daysInFiveYears += monthDate.monthDays
            }
        }
        
        // Making content for all of the days in the 5 years
        let dMod = DayModel(content: content)
        dayContent = Array(repeating: dMod, count: daysInFiveYears)
    }
    
    // MARK: - Access to the Model
    var years: [String] {
        var allYears = [String]()
        for year in calendarContent {
            allYears.append(year.name)
        }
        return allYears
    }
    
    var texts: [String] {
        get {
            let dayArray = dayContent[indexForTexts].content
            var result = [String]()
            
            dayArray.forEach({ content in
                result.append(content[1])
            })
            
            return result
        }
        set {
            let dayArray = dayContent[indexForTexts].content
            
            var result = [String]()
            
            dayArray.forEach({ content in
                result.append(content[1])
            })
            
            result = newValue
        }
    }
    
    var indexForTexts = 0
    
//    var months: [String] {
//        let monhtsCount = dayContent.count
//        var result = [String]()
//
//        for actualMonth in 0...monhtsCount {
//            result.append(monthsString[actualMonth])
//        }
//
//        return result
//    }
    
    var month: String {
        let month = Date().month
        return monthsString[month]
    }
    
//    var day: String {
//        String(Date().day)
//    }
    
//    var pageDate: String {
//        month + " " + day
//    }
    
    // MARK: - Intent
}
