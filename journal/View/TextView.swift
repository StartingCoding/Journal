//
//  TextView.swift
//  journal
//
//  Created by Loris on 12/23/20.
//

import SwiftUI

struct TextView: View {
    var textToDisplay: String
    
    var body: some View {
        VStack {
            Text(textToDisplay)
                .truncationMode(.tail)
        }
        .padding(.trailing)
    }
}
