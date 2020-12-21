//
//  YearsOfDayView.swift
//  journal
//
//  Created by Loris on 12/17/20.
//

import SwiftUI

struct YearsOfDayView: View {
    var year: Int
    var text: String
    
    var body: some View {
        HStack {
            Text("\(year)")
                .padding()
            
            Text("\(text)")
                .padding()
        }
    }
}

struct yearsOfDayTextView_Previews: PreviewProvider {
    static var previews: some View {
        let journalPage = JournalPage()
        
        YearsOfDayView(year: journalPage.years.first!, text: journalPage.texts.first!)
    }
}
