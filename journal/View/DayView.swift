//
//  DayView.swift
//  journal
//
//  Created by Loris on 12/16/20.
//

import SwiftUI

struct DayView: View {
    @ObservedObject var todayPage: TodayPage
    
    var body: some View {
        NavigationView {
            VStack {
                Divider()
                
                ForEach(0..<todayPage.years.count) { row in
                    HStack {
                        Text("\(todayPage.years[row])")
                            .underline(true, color: .yellow)
                            .fontWeight(.bold)
                            .padding(.leading)
                        Spacer()
                        DayCard(text: todayPage.texts[row], fullDate: todayPage.pageDate + ", \(todayPage.years[row])")
                    }
                }
                
                Divider()
            }
            // Views Modifiers for Navigation
            .navigationBarTitle(Text(todayPage.pageDate))
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
            DayView(todayPage: TodayPage())
        }
    }
}
