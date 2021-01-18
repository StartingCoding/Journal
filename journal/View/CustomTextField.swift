//
//  CustomTextField.swift
//  journal
//
//  Created by Loris on 12/25/20.
//

// Following: https://www.youtube.com/watch?v=0N-bUVqou8E
// and: https://www.youtube.com/watch?v=Ek_r-7aRp3A

import SwiftUI

struct TestTextField: UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<TestTextField>) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<TestTextField>) {
//        uiView.becomeFirstResponder()
//        context.coordinator.textFieldDidBeginEditing?(T##textField: UITextField##UITextField)
    }
    
    func makeCoordinator() -> (TestTextField.Coordinator) {
        return Coordinator()
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
//        func textFieldDidBeginEditing(_ textField: UITextField) {
//            textField.becomeFirstResponder()
//        }
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
