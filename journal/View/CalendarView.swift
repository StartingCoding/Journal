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
                List(todayPage.calendarContent, id: \.name, children: \.subCalModel) { item in
                    NavigationLink(destination: DayView(todayPage: todayPage)) {
                        Text("\(item.name)")
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
