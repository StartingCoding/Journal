//
//  JournalPage.swift
//  journal
//
//  Created by Loris on 12/17/20.
//

import Foundation

class JournalPage {
    // MARK: - Model
    private var journal = makeUserPlaceholder()
    
    static func makeUserPlaceholder() -> Journal {
        var years = [Int]()
        for year in 2021..<2026 {
            years.append(year)
        }
        
        let textPlaceholder = """
        -------------------------------
        -------------------------------
        -------------------------------
        """
        
        var texts = [String]()
        for _ in 0..<years.count {
            texts.append(textPlaceholder)
        }
        
        return Journal(years: years, texts: texts)
    }
    
    // MARK: - Access to the Model
    var years: [Int] {
        journal.years
    }
    
    var texts: [String] {
        journal.texts
    }
    
    var day: String {
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter.string(from: today)
    }
}
