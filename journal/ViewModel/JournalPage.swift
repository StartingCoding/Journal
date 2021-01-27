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
        page = JournalPage.makeUserPlaceholder()
    }
    
    static func makeUserPlaceholder() -> Page {
        let pageLoaded = Bundle.main.decode([Page].self, from: "pages.json")
        
        return pageLoaded.first!
    }
    
    // MARK: - Access to the Model
    var years: [Int] {
        page.allYears
    }
    
    var texts: [String] {
        page.allTexts!
    }
    
    var day: Int {
        page.day
    }
    
    var today: String {
        let formatter = DateFormatter()
        let today = Date()
        
        formatter.locale = Locale.autoupdatingCurrent
        formatter.setLocalizedDateFormatFromTemplate("MMMMd")
        return formatter.string(from: today)
    }
}
