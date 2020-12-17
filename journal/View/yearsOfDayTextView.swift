//
//  yearsOfDayTextView.swift
//  journal
//
//  Created by Loris on 12/17/20.
//

import SwiftUI

struct yearsOfDayTextView: View {
    var textToShow: String
    
    var body: some View {
        VStack {
            Text(textToShow)
        }
        .padding()
    }
}

struct yearsOfDayTextView_Previews: PreviewProvider {
    static var previews: some View {
        yearsOfDayTextView(textToShow: """
    -------------------------------
    -------------------------------
    -------------------------------
    """)
    }
}
