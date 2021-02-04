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
        let pageLoaded = TodayPage.loadPages(decoding: Page.self, from: filename)
        
        return pageLoaded
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
//    func writeNewTodayPageToDocumentsFolder(textToUpdate: String, fullDate: String) {
//        // load and decode pages from json
//        var loadedPages = FileManager.default.decode([Page].self, from: "pages.json")
//        print(loadedPages)
//        // check if todaypage already exists in loadedpages
//        for (index, page) in loadedPages.enumerated() {
//            if fullDate.contains(page.day) && fullDate.contains(page.month) {
//                // remove old page if there is one
//                loadedPages.remove(at: index)
//                print(loadedPages)
//            }
//        }
//        // insert todaypage in loadedpages
//        loadedPages.append(todayPage)
//        print(loadedPages)
//        // encode new pages and write it back to json
//        FileManager.default.writePagesToDocumentsFolder(pages: loadedPages, to: "pages.json")
//    }
}
