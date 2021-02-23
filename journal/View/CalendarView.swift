//
//  CalendarView.swift
//  journal
//
//  Created by Loris on 06/02/21.
//

import SwiftUI
import SwiftDate

struct CalendarView: View {
    @ObservedObject var calendarPage: CalendarPage
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    CalendarListView(calendarContent: calendarPage.calendarContent)
                    Spacer()
                }
            }
            .navigationBarTitle(Text("🗓"))
            .navigationBarTitleDisplayMode(.large)
        }
        .environmentObject(calendarPage)
    }
}


// MARK: List of Years
struct CalendarListView: View {
    var calendarContent: [CalModel]
    @State private var showingYears = false
    
    var body: some View {
        Button(action: {
            showingYears.toggle()
        }, label: {
            HStack {
                Text("5 Years")
                    .foregroundColor(Color.primary)
                Spacer()
                Image(systemName: showingYears ? "chevron.down" : "chevron.right")
            }
            .padding()
        })
        
        if showingYears {
            CalendarYearRowView(calendarContent: calendarContent)
        }
    }
}


// MARK: Year Row
struct CalendarYearRowView: View {
    var calendarContent: [CalModel]
    @State private var showingMonths: [Bool]
    
    var body: some View {
        ForEach(0..<calendarContent.count) { index in
            Button(action: {
                showingMonths[index].toggle()
            }, label: {
                HStack {
                    Text(calendarContent[index].name)
                        .foregroundColor(Color.primary)
                    Spacer()
                    Image(systemName: showingMonths[index] ? "chevron.down" : "chevron.right")
                }
                .padding()
            })
            
            if showingMonths[index] {
                CalendarMonthRowView(year: calendarContent[index])
            }
        }
    }
    
    init(calendarContent: [CalModel]) {
        self.calendarContent = calendarContent
        self._showingMonths = State(initialValue: Array(repeating: false, count: calendarContent.count))
    }
}


// MARK: Month Row
struct CalendarMonthRowView: View {
    var year: CalModel
    var months: [CalModel]
    
    @State private var showingDays: [Bool]
    
    var body: some View {
        ForEach(0..<months.count) { index in
            Button(action: {
                showingDays[index].toggle()
            }, label: {
                HStack {
                    Text(months[index].name)
                        .foregroundColor(Color.primary)
                        .padding(.leading)
                    Spacer()
                    Image(systemName: showingDays[index] ? "chevron.down" : "chevron.right")
                }
                .padding()
            })
            
            if showingDays[index] {
                CalendarDayRowView(month: months[index])
            }
        }
    }
    
    init(year: CalModel) {
        self.year = year
        
        if let months = self.year.subCalModel {
            self.months = months
        } else {
            fatalError("🔴 Months not founded in a specific year")
        }
        
        self._showingDays = State(initialValue: Array(repeating: false, count: months.count))
    }
}


// MARK: Day Row
struct CalendarDayRowView: View {
    var month: CalModel
    var days: [CalModel]
    
    @EnvironmentObject var calendarPage: CalendarPage
    
    var body: some View {
        ForEach(days, id: \.name) { day in
            NavigationLink(destination: DayView(day: month.name + " " + day.name, todayPage: calendarPage)) {
                HStack {
                    Text("Day \(day.name)")
                        .foregroundColor(Color.primary)
                        .padding(.leading)
                        .padding(.leading)
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .padding()
            }
        }
    }
    
    init(month: CalModel) {
        self.month = month
        
        if let days = self.month.subCalModel {
            self.days = days
        } else {
            fatalError("🔴 Months not founded in a aspecific month")
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(calendarPage: CalendarPage())
    }
}
