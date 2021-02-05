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
        // Create a date from now so it can be compared
        let todayDate = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale.autoupdatingCurrent
        
        formatter.dateFormat = "dd-MM-yyyy"
        let filename = formatter.string(from: todayDate) + ".json"
        // Loading pages from Documents folder by FileManager
        let pageLoaded = TodayPage.loadTodayPage(decoding: Page.self, from: filename)
        
        return pageLoaded
    }
    
    static func loadTodayPage<T: Decodable>(decoding type: T.Type, from filename: String) -> T {
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
        get { todayPage.allTexts }
        set { todayPage.allTexts = newValue }
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
    func savePageToDocumentsFolder() {
        // Create a date from now so it can be compared
        let todayDate = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale.autoupdatingCurrent
        
        formatter.dateFormat = "dd-MM-yyyy"
        let filename = formatter.string(from: todayDate) + ".json"
        
        let path = FileManager.default.getDocumentsDirectory().appendingPathComponent(filename)
        
        // Encode the new page and write it to the correct file aka the JSON page of today
        let data = FileManager.default.encode(todayPage)
        
        do {
            try data.write(to: path, options: .atomic)
        } catch {
            fatalError("🔴 Failed to write new page data in JSON file in Documents folder: \(error.localizedDescription)")
        }
    }
}
