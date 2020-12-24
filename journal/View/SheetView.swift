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
                
                CustomTextField(text: $textBinding, isFirstResponder: true)
                
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

// Custom TextFIeld taken from https://stackoverflow.com/questions/56507839/swiftui-how-to-make-textfield-become-first-responder
// also see this https://stackoverflow.com/questions/59990634/swiftui-custom-textfield-with-uiviewrepresentable-issue-with-observableobject-an
// TODO: - Integrate a UITextField from UIKit into SwiftUI
struct CustomTextField: UIViewRepresentable {

    class Coordinator: NSObject, UITextFieldDelegate {

        @Binding var text: String
        var didBecomeFirstResponder = false

        init(text: Binding<String>) {
            _text = text
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }

    }

    @Binding var text: String
    var isFirstResponder: Bool = false

    func makeUIView(context: UIViewRepresentableContext<CustomTextField>) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.delegate = context.coordinator
        return textField
    }

    func makeCoordinator() -> CustomTextField.Coordinator {
        return Coordinator(text: $text)
    }

    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<CustomTextField>) {
        uiView.text = text
        if isFirstResponder && !context.coordinator.didBecomeFirstResponder  {
            uiView.becomeFirstResponder()
            context.coordinator.didBecomeFirstResponder = true
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
