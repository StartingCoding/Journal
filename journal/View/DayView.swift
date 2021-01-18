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
        NavigationView {
            VStack {
                ForEach(0..<journalPage.years.count) { row in
                    HStack {
                        Text("\(journalPage.years[row])")
                            .underline(true, color: .yellow)
                            .fontWeight(.bold)
                            .padding(.leading)
                        Spacer()
                        DayCard(textToDisplay: journalPage.texts[row])
                    }
                }
            }
            // Views Modifiers for Navigation
            .navigationBarTitle(Text(journalPage.today))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button("🗓") {  },
                trailing: Button("👤") {  }
            )
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
