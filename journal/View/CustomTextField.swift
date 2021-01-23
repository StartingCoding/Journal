//
//  CustomTextView.swift
//  journal
//
//  Created by Loris on 12/25/20.
//

// https://stackoverflow.com/questions/56507839/swiftui-how-to-make-textfield-become-first-responder

import SwiftUI
import UIKit

struct CustomTextView: UIViewRepresentable {
    @Binding var text: String
    
    func makeUIView(context: UIViewRepresentableContext<CustomTextView>) -> UITextView {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 22)
        textView.delegate = context.coordinator
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<CustomTextView>) {
        uiView.text = text
        uiView.becomeFirstResponder()
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
