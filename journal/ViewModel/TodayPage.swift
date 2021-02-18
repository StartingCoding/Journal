//
//  TodayPage.swift
//  journal
//
//  Created by Loris on 12/17/20.
//

// https://matteomanferdini.com/codable/

import Foundation

class TodayPage: ObservableObject {
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
        
        var mArray = [CalModel]()
        var yArray = [CalModel]()
        
        for num in 0...11 {
            
            let calMod = CalModel(name: monthsString[num])
            mArray.append(calMod)
        }
        
        for num in 0...4 {
            let calMod = CalModel(name: "\(actualYear + num)", subCalModel: mArray)
            yArray.append(calMod)
        }
        
        calendarContent = yArray
        
        let dMod = DayModel(content: content)
        dayContent = [dMod]
    }
    
//    static func makeTodayPage() -> Page {
//        // Create a date from now so it can be compared
//        let todayDate = Date()
//        let formatter = DateFormatter()
//        formatter.locale = Locale.autoupdatingCurrent
//
//        formatter.dateFormat = "dd-MM-yyyy"
//        let filename = formatter.string(from: todayDate) + ".json"
//        // Loading pages from Documents folder by FileManager
//        let pageLoaded = TodayPage.loadTodayPage(decoding: Page.self, from: filename)
//
//        return pageLoaded
//    }
    
//    static func loadTodayPage<T: Decodable>(decoding type: T.Type, from filename: String) -> T {
//        let filenamePath = FileManager.default.getDocumentsDirectory().appendingPathComponent(filename)
//
//        // If the file doesn't exists, write it a new one with just one blank page taken from today
//        if FileManager.default.fileExists(atPath: filenamePath.path) == false {
//            let blankTodayPage = TodayPage.makeBlankTodayPage()
//            FileManager.default.writeBlankTodayPageToDocumentsFolder(blankTodayPage, to: filename)
//        }
//
//        return FileManager.default.decode(T.self, from: filename)
//    }
    
//    static func makeBlankTodayPage() -> Page {
//        let formatter = DateFormatter()
//        let todayDate = Date()
//        formatter.locale = Locale.autoupdatingCurrent
//
//        formatter.setLocalizedDateFormatFromTemplate("dd")
//        let todayDay = formatter.string(from: todayDate)
//
//        formatter.setLocalizedDateFormatFromTemplate("MMMM")
//        let todayMonth = formatter.string(from: todayDate)
//
//        formatter.setLocalizedDateFormatFromTemplate("yyyy")
//        let todayYear = formatter.string(from: todayDate)
//
//        var years = [Int]()
//        var texts = [String]()
//        let placeholder = "---------------------------------------------------------------------------------------------"
//        for iterator in 0..<5 {
//            years.append(Int(todayYear)! + iterator)
//            texts.append(placeholder)
//        }
//
//        let blankPage = Page(day: todayDay, month: todayMonth, allYears: years, allTexts: texts, pageContent: [String : String]())
//        return blankPage
//    }
    
    
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
