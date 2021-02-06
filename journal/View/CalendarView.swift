//
//  CalendarView.swift
//  journal
//
//  Created by Loris on 06/02/21.
//

import SwiftUI

struct CalendarView: View {
    var body: some View {
        NavigationView {
            List(1..<6) { row in
                NavigationLink(destination: DayView(todayPage: TodayPage())) {
                    Text("\(row) row")
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle(Text("🗓"))
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
