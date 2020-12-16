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
            Text("1st")
                .padding()
            
            Text("2020")
                .padding()
            Text("2021")
                .padding()
            Text("2022")
                .padding()
            Text("2023")
                .padding()
            Text("2024")
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DayView()
    }
}
