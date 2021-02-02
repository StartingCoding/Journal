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
    @Published private var todayPage: Page
    
    init() {
        todayPage = TodayPage.makeTodayPage()
    }
    
    static func makeTodayPage() -> Page {
        // Loading pages from Documents folder by FileManager
        let pagesLoaded = TodayPage.loadPages(decoding: [Page].self, from: "pages.json")
        
        // Create a date from now so it can be compared with dates from the pages array
        let todayDate = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale.autoupdatingCurrent
        formatter.setLocalizedDateFormatFromTemplate("MMMMd")
        let today = formatter.string(from: todayDate)
        
        // Check if the array contains a page from today and return it
        for page in pagesLoaded {
            if today.contains(page.day) && today.contains(page.month) {
                return page
            }
        }
        
        // If we didn't found a page from the array create a blank page from today and write it to the file
        let blankTodayPage = TodayPage.makeBlankTodayPage()
        FileManager.default.writeBlankTodayPageToDocumentsFolder(blankTodayPage, to: "pages.json")
        
        return blankTodayPage
    }
    
    static func loadPages<T: Decodable>(decoding type: T.Type, from filename: String) -> T {
        let filenamePath = FileManager.default.getDocumentsDirectory().appendingPathComponent(filename)

        // If the file doesn't exists, write it a new one with just one blank page taken from today
        if FileManager.default.fileExists(atPath: filenamePath.path) == false {
            let blankTodayPage = TodayPage.makeBlankTodayPage()
            FileManager.default.writeBlankTodayPageToDocumentsFolder(blankTodayPage, to: filename)
        }
        
        return FileManager.default.decode(T.self, from: filename)
    }
    
    static func makeBlankTodayPage() -> Page {
        let formatter = DateFormatter()
        let todayDate = Date()
        formatter.locale = Locale.autoupdatingCurrent
        
        formatter.setLocalizedDateFormatFromTemplate("dd")
        let todayDay = formatter.string(from: todayDate)
        
        formatter.setLocalizedDateFormatFromTemplate("MMMM")
        let todayMonth = formatter.string(from: todayDate)
        
        formatter.setLocalizedDateFormatFromTemplate("yyyy")
        let todayYear = formatter.string(from: todayDate)
        
        var years = [Int]()
        var texts = [String]()
        let placeholder = "---------------------------------------------------------------------------------------------"
        for iterator in 0..<5 {
            years.append(Int(todayYear)! + iterator)
            texts.append(placeholder)
        }
        
        let blankPage = Page(day: todayDay, month: todayMonth, allYears: years, allTexts: texts, pageContent: [String : String]())
        return blankPage
    }
    
    
    // MARK: - Access to the Model
    var years: [Int] {
        todayPage.allYears
    }
    
    var texts: [String] {
        todayPage.allTexts
    }
    
    var month: String {
        todayPage.month
    }
    
    var day: String {
        todayPage.day
    }
    
    var pageDate: String {
        month + " " + day
    }
    
    // MARK: - Intent
    
    func updateTodayPage(newPage: Page) {
        // Write changes to the file
        FileManager.default.writeBlankTodayPageToDocumentsFolder(newPage, to: "pages.json")
        // Reload the pages
        let updatedPages = FileManager.default.decode([Page].self, from: "pages.json")
        // Assign the new today page to the Published var so it can update all the views
        todayPage = updatedPages.first!
    }
}
