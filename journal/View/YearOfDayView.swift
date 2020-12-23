//
//  YearOfDayView.swift
//  journal
//
//  Created by Loris on 12/17/20.
//

import SwiftUI

struct YearOfDayView: View {
    var year: Int
    var text: String
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                Text("\(year)")
                    .underline(true, color: .yellow)
                    .frame(width: geometry.size.width * 0.30, height: geometry.size.height, alignment: .top)
                
                TextView(textToDisplay: text)
                    .frame(width: geometry.size.width * 0.70, height: geometry.size.height, alignment: .topLeading)
            }
        }
    }
}

struct yearsOfDayTextView_Previews: PreviewProvider {
    static var previews: some View {
        let journalPage = JournalPage()
        
        YearOfDayView(year: journalPage.years.first!, text: journalPage.texts.first!)
    }
}
