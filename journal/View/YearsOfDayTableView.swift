//
//  YearsOfDayTableView.swift
//  journal
//
//  Created by Loris on 12/17/20.
//

import SwiftUI

struct YearsOfDayTableView: View {
    var years: [Int]
    var texts: [String]
    
    var body: some View {
        ForEach(0..<years.count) { index in
            YearsOfDayView(year: years[index], text: texts[index])
        }
    }
}

struct yearsOfDayView_Previews: PreviewProvider {
    static var previews: some View {
        let journalPage = JournalPage()
        
        YearsOfDayTableView(years: journalPage.years, texts: journalPage.texts)
    }
}
