//
//  ChangeView.swift
//  journal
//
//  Created by Loris on 12/24/20.
//

import SwiftUI

struct ChangeView: View {
    @Binding var showingModal: Bool
    @Binding var textToShow: String
    var day: String
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 20.0)
                        .fill(Color("whiteBg"))
                        .shadow(color: Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.25), radius: 8, x: 0.0, y: 4.0)
                    
                    CustomTextView(text: $textToShow)
                        .padding()
                }
                .padding()
                Spacer()
            }
            .background(Color("grayBg"))
            .navigationBarTitle(Text(day), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                showingModal = false
            }) {
                Text("Done").bold()
            })
        }
    }
}

struct ChangeView_Previews: PreviewProvider {
    static var previews: some View {
        let journal = JournalPage()
        
        ChangeView(showingModal: Binding.constant(true), textToShow: Binding.constant(journal.texts[0]), day: journal.day)
    }
}
