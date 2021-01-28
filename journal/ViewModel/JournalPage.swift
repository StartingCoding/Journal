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
        let pagesLoaded = Bundle.main.decode([Page].self, from: "pages.json")
        
        var today: String
        let formatter = DateFormatter()
        let todayDate = Date()
        formatter.locale = Locale.autoupdatingCurrent
        formatter.setLocalizedDateFormatFromTemplate("MMMMd")
        today = formatter.string(from: todayDate)
        
        var todayPage = JournalPage.makeBlankPage()
        
        for page in pagesLoaded {
            if today.contains(page.day) && today.contains(page.month) {
                todayPage = page
            }
        }
        
        return todayPage
    }
    
    static func makeBlankPage() -> Page {
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
