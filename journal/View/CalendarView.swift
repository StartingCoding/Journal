//
//  CalendarView.swift
//  journal
//
//  Created by Loris on 06/02/21.
//

import SwiftUI
import SwiftDate

struct CalendarView: View {
    @ObservedObject var todayPage: TodayPage
    
    var body: some View {
        NavigationView {
            GroupBox(label: Text("Years")) {
                List(todayPage.years, id: \.self) { year in
                    NavigationLink(destination: DayView(todayPage: todayPage)) {
                        Text("\(year)")
                    }
                }
            }
            .navigationBarTitle(Text("🗓"))
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(todayPage: TodayPage())
    }
}
