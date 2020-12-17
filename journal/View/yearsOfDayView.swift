//
//  yearsOfDayView.swift
//  journal
//
//  Created by Loris on 12/17/20.
//

import SwiftUI

struct yearsOfDayView: View {
    var body: some View {
        ForEach(0..<5) { lastDigit in
            HStack {
                Text("202\(lastDigit)")
                    .padding()
                
                yearsOfDayTextView(textToShow: """
    -------------------------------
    -------------------------------
    -------------------------------
    """)
            }
        }
    }
}

struct yearsOfDayView_Previews: PreviewProvider {
    static var previews: some View {
        yearsOfDayView()
    }
}
