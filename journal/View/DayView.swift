//
//  DayView.swift
//  journal
//
//  Created by Loris on 12/16/20.
//

import SwiftUI

struct DayView: View {
    var journalPage = JournalPage()
    
    var body: some View {
        VStack {
            Text("\(journalPage.day)")
                .padding()
            
            YearsOfDayTableView(years: journalPage.years, texts: journalPage.texts)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DayView()
        }
    }
}
