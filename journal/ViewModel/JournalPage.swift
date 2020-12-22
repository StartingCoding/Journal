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
        let pageLoaded = Bundle.main.decode([Page].self, from: "data.json")
        
        var years = [Int]()
        var texts = [String]()
        
        for index in 0..<pageLoaded.count {
            years.append(pageLoaded[index].year)
            texts.append(pageLoaded[index].body)
        }
        
        let day = pageLoaded.first!.day
        
//        let textPlaceholder = """
//        -------------------------------
//        -------------------------------
//        -------------------------------
//        """
        
        return Journal(years: years, texts: texts, day: day)
    }
    
    // MARK: - Access to the Model
    var years: [Int] {
        journal.years
    }
    
    var texts: [String] {
        journal.texts
    }
    
    var day: Int {
        journal.day
    }
    
    var today: String {
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter.string(from: today)
    }
}
