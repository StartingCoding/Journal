//
//  DayView.swift
//  journal
//
//  Created by Loris on 12/16/20.
//

import SwiftUI

struct DayView: View {
    var body: some View {
        VStack {
            Text("Day")
                .padding()
            
            yearsOfDayView()
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
