//
//  CustomTextView.swift
//  journal
//
//  Created by Loris on 12/25/20.
//

// https://www.youtube.com/watch?v=Ek_r-7aRp3A
// https://stackoverflow.com/questions/56507839/swiftui-how-to-make-textfield-become-first-responder

import SwiftUI
import UIKit

struct CustomTextView: UIViewRepresentable {
    @Binding var text: String
    
    func makeUIView(context: UIViewRepresentableContext<CustomTextView>) -> UITextView {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 22)
        textView.delegate = context.coordinator
        textView.becomeFirstResponder()
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<CustomTextView>) {
        uiView.text = text
    }
    
    func makeCoordinator() -> (CustomTextView.Coordinator) {
        return Coordinator(text: $text)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        @Binding var text: String
        
        init(text: Binding<String>) {
            _text = text
        }
        
        func textViewDidChange(_ textView: UITextView) {
            text = textView.text
        }
    }
}


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
