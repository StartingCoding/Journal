//
//  journalApp.swift
//  journal
//
//  Created by Loris on 12/16/20.
//

import SwiftUI

@main
struct journalApp: App {
    var body: some Scene {
        WindowGroup {
            CalendarView(calendarPage: CalendarPage())
        }
    }
}
