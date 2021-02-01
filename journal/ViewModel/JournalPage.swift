//
//  JournalPage.swift
//  journal
//
//  Created by Loris on 12/17/20.
//

// https://matteomanferdini.com/codable/

import Foundation

class JournalPage: ObservableObject {
    // MARK: - Model
    @Published private var page: Page
    
    init() {
        page = JournalPage.makeTodayPage()
    }
    
    static func makeTodayPage() -> Page {
        // Loading pages from FileSystem
        let pagesLoaded = JournalPage.loadPages(decoding: [Page].self, from: "pages.json")
        
        let formatter = DateFormatter()
        let todayDate = Date()
        formatter.locale = Locale.autoupdatingCurrent
        formatter.setLocalizedDateFormatFromTemplate("MMMMd")
        let today = formatter.string(from: todayDate)
        
        var todayPage = JournalPage.makeBlankTodayPage()
        
        for page in pagesLoaded {
            if today.contains(page.day) && today.contains(page.month) {
                todayPage = page
                return todayPage
            }
        }
        FileManager.default.writeJSONToDocumentsFolder(todayPage, to: "pages.json")
        
        return todayPage
    }
    
    static func loadPages<T: Decodable>(decoding type: T.Type, from filename: String) -> T {
        let filenamePath = FileManager.default.getDocumentsDirectory().appendingPathComponent(filename)

        // If file doesn't exists create it with one blank page from today
        if FileManager.default.fileExists(atPath: filenamePath.path) == false {
            let blankTodayPage = JournalPage.makeBlankTodayPage()
            FileManager.default.writeJSONToDocumentsFolder(blankTodayPage, to: "pages.json")
        }
        
        return FileManager.default.decode(T.self, from: "pages.json")
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
        page.allYears
    }
    
    var texts: [String] {
        page.allTexts
    }
    
    var month: String {
        page.month
    }
    
    var day: String {
        page.day
    }
    
    var pageDate: String {
        month + " " + day
    }
}
