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
    @State private var revealDetails = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                CalendarListView(calendarContent: todayPage.calendarContent)
                Spacer()
                
//                List(todayPage.calendarContent, id: \.name, children: \.subCalModel) { item in
//                    if item.subCalModel == nil {
//                        NavigationLink(destination: DayView(todayPage: todayPage)) {
//                            Text("\(item.name)")
//                        }
//                    } else {
//                        Text(item.name)
//                    }
//                }
            }
            .background(Color.gray)
            .navigationBarTitle(Text("🗓"))
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct CalendarListView: View {
    var calendarContent: [CalModel]
    
    @State private var yearsBool = false
    @State private var yearBool = false
    
    var body: some View {
        Button(action: {
            yearsBool.toggle()
        }, label: {
            HStack {
                Text("5 Years")
                    .foregroundColor(Color.primary)
                Spacer()
                Image(systemName: yearsBool ? "chevron.down" : "chevron.right")
            }
            .padding()
        })
        
        if yearsBool {
            ForEach(calendarContent, id: \.name) { year in
                Button(action: {
                    yearBool.toggle()
                }, label: {
                    HStack {
                        Text(year.name)
                            .foregroundColor(Color.primary)
                        Spacer()
                        Image(systemName: yearsBool ? "chevron.down" : "chevron.right")
                    }
                    .padding()
                })
                
                if yearBool {
                    if let subCal = year.subCalModel {
                        ForEach(subCal, id: \.name) { item in
                            Text("\(item.name)")
                        }
                    }
                }
            }
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(todayPage: TodayPage())
    }
}
