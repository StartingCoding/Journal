//
//  TextView.swift
//  journal
//
//  Created by Loris on 12/23/20.
//

import SwiftUI

struct TextView: View {
    var textToDisplay: String
    @State var showingModal = false
    
    var body: some View {
        VStack {
            Text(textToDisplay)
                .truncationMode(.tail)
        }
        .padding(.trailing)
        .onTapGesture {
            showingModal.toggle()
        }
        .sheet(isPresented: $showingModal, content: {
            SheetView(showingModal: $showingModal, textToShow: textToDisplay, textBinding: "Insert some text")
        })
    }
}
