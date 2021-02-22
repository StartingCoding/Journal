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
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    CalendarListView(calendarContent: todayPage.calendarContent)
                    Spacer()
                }
            }
            .background(Color.gray)
            .navigationBarTitle(Text("🗓"))
            .navigationBarTitleDisplayMode(.large)
        }
    }
}


// MARK: List
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
            CalendarYearRowView(calendarContent: calendarContent, yearsBool: showingYears)
        }
    }
}


// MARK: Year Row
struct CalendarYearRowView: View {
    var calendarContent: [CalModel]
    var yearsBool: Bool
    
    @State private var yearBool: [Bool]
    
    var body: some View {
        ForEach(0..<calendarContent.count) { index in
            Button(action: {
                yearBool[index].toggle()
            }, label: {
                HStack {
                    Text(calendarContent[index].name)
                        .foregroundColor(Color.primary)
                    Spacer()
                    Image(systemName: yearsBool ? "chevron.down" : "chevron.right")
                }
                .padding()
            })
            
            if yearBool[index] {
                CalendarMonthRowView(year: calendarContent[index], showingMonth: yearBool[index])
            }
        }
    }
    
    init(calendarContent: [CalModel], yearsBool: Bool) {
        self.calendarContent = calendarContent
        self.yearsBool = yearsBool
        
        self._yearBool = State(initialValue: Array(repeating: false, count: calendarContent.count))
    }
}


// MARK: Month Row
struct CalendarMonthRowView: View {
    var year: CalModel
    var months: [CalModel]
    
    @State private var showingDays: [Bool]
    var showingMonth: Bool
    
    var body: some View {
        ForEach(0..<months.count) { index in
            Button(action: {
                showingDays[index].toggle()
            }, label: {
                HStack {
                    Text(months[index].name)
                        .foregroundColor(Color.primary)
                    Spacer()
                    Image(systemName: showingMonth ? "chevron.down" : "chevron.right")
                }
                .padding()
            })
            
            if showingDays[index] {
                Text("Success!")
            }
        }
    }
    
    init(year: CalModel, showingMonth: Bool) {
        self.year = year
        
        if let months = self.year.subCalModel {
            self.months = months
        } else {
            fatalError("🔴 Months not found in a specific year")
        }
        
        self._showingDays = State(initialValue: Array(repeating: false, count: months.count))
        self.showingMonth = showingMonth
    }
}


// MARK: Day Row
struct CalendarDayRowView: View {
    var month: CalModel
    
    var body: some View {
        Text("\(month.name)")
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(todayPage: TodayPage())
    }
}
