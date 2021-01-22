//
//  JournalPage.swift
//  journal
//
//  Created by Loris on 12/17/20.
//

import Foundation

class JournalPage: ObservableObject {
    // MARK: - Model
    @Published private var journal = makeUserPlaceholder()
    
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
        
        return Journal(day: day, years: years, texts: texts)
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
        let formatter = DateFormatter()
        let today = Date()
        
        formatter.locale = Locale.autoupdatingCurrent
        formatter.setLocalizedDateFormatFromTemplate("MMMMd")
        return formatter.string(from: today)
    }
}
