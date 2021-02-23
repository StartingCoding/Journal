//
//  TodayPage.swift
//  journal
//
//  Created by Loris on 12/17/20.
//

// https://matteomanferdini.com/codable/

import Foundation

class CalendarPage: ObservableObject {
    // MARK: - Model
    @Published private var dayContent: [DayModel]
    var calendarContent: [CalModel]
    
    let monthsString = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    init() {
        let actualYear = Date().year
        let content = [
            ["year 1", "text 1"],
            ["year 2", "text 2"],
            ["year 3", "text 3"],
            ["year 4", "text 4"],
            ["year 5", "text 5"]
        ]
        
//        var dArray = [CalModel]()
        var mArray = [CalModel]()
        var yArray = [CalModel]()
        
        // Making months
        for month in 0...11 {
            let dateMonth = Date {
                $0.month = month + 1
            }
            var dArray = [CalModel]()
            for day in 1...dateMonth!.monthDays {
                let calMod = CalModel(name: "\(day)")
                dArray.append(calMod)
            }
            
            let calMod = CalModel(name: monthsString[month], subCalModel: dArray)
            mArray.append(calMod)
        }
        
        // Making Years
        for num in 0...4 {
            let calMod = CalModel(name: "\(actualYear + num)", subCalModel: mArray)
            yArray.append(calMod)
        }
        
        calendarContent = yArray
        
        let dMod = DayModel(content: content)
        dayContent = [dMod]
    }
    
    // MARK: - Access to the Model
    var years: [String] {
        let dayArray = dayContent[(Int(month) ?? 1) - 1].content
        
        var result = [String]()
        
        dayArray.forEach({ content in
            result.append(content[0])
        })
        
        return result.sorted()
    }
    
    var texts: [String] {
        get {
            let dayArray = dayContent[(Int(month) ?? 1) - 1].content
            
            var result = [String]()
            
            dayArray.forEach({ content in
                result.append(content[1])
            })
            
            return result.sorted()
        }
        set {
            let dayArray = dayContent[(Int(month) ?? 1) - 1].content
            
            var result = [String]()
            
            dayArray.forEach({ content in
                result.append(content[1])
            })
            
            result = newValue
        }
    }
    
    var months: [String] {
        let monhtsCount = dayContent.count
        var result = [String]()
        
        for actualMonth in 0...monhtsCount {
            result.append(monthsString[actualMonth])
        }
        
        return result
    }
    
    var month: String {
        let month = Date().month
        return monthsString[month]
    }
    
    var day: String {
        String(Date().day)
    }
    
    var pageDate: String {
        month + " " + day
    }
    
    // MARK: - Intent
}
