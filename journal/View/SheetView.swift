//
//  SheetView.swift
//  journal
//
//  Created by Loris on 12/24/20.
//

import SwiftUI

struct SheetView: View {
    @Binding var showingModal: Bool
    var textToShow: String
    @State var textBinding: String
    
    var body: some View {
        NavigationView {
            VStack {
                Text("\(textToShow)")
                    .cardifyText()
                
//                TextField("Insert some text", text: $textBinding)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
//                CustomTextField(text: $textBinding, isFirstResponder: true)
                TestTextField()
                
                Text("Insert New Text")
                    .cardifyText()
                
                Spacer()
            }
            .navigationBarTitle(Text("Insert Text"), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                print("Dismissing sheet view...")
                showingModal = false
            }) {
                Text("Done").bold()
            })
        }
    }
}

struct CardifyText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .frame(maxWidth: .infinity)
            .padding()
            .foregroundColor(Color.white)
            .background(Color.blue)
    }
}

extension View {
    func cardifyText() -> some View {
        modifier(CardifyText())
    }
}

struct ModalSheetView_Previews: PreviewProvider {
    static var previews: some View {
//        ModalSheetView(showingModal: Binding<true>, textToShow: "Some text to show")
        Text("Some text")
            .cardifyText()
    }
}
