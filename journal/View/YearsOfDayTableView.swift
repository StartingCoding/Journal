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
        VStack {
            ForEach(0..<years.count) { index in
                YearOfDayView(year: years[index], text: texts[index])
            }
            .padding(.top)
        }
        .background(Color("backgroundText"))
    }
}

struct yearsOfDayView_Previews: PreviewProvider {
    static var previews: some View {
        let journalPage = JournalPage()
        
        YearsOfDayTableView(years: journalPage.years, texts: journalPage.texts)
    }
}
