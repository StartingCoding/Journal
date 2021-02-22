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
            VStack(alignment: .leading) {
                CalendarListView(calendarContent: todayPage.calendarContent)
                Spacer()
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
            CalendarYearRowView(calendarContent: calendarContent, yearsBool: yearsBool)
        }
    }
}

struct CalendarYearRowView: View {
    var calendarContent: [CalModel]
    var yearsBool: Bool
    
    @State private var yearBool = false
    
    var body: some View {
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
                CalendarMonthRowView(year: year)
            }
        }
    }
}

struct CalendarMonthRowView: View {
    var year: CalModel
    var months: [CalModel] {
        if let months = year.subCalModel {
            return months
        } else {
            fatalError("🔴 Months not found in a specific year")
        }
    }
    
    var body: some View {
        ForEach(months, id: \.name) { month in
            Text("\(month.name)")
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(todayPage: TodayPage())
    }
}
