//
//  ChangeView.swift
//  journal
//
//  Created by Loris on 12/24/20.
//

import SwiftUI

struct ChangeView: View {
    @EnvironmentObject var todayPage: TodayPage
    
    @Binding var text: String
    var fullDate: String
    
    @Binding var isShowing: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 20.0)
                        .fill(Color("whiteBg"))
                        .shadow(color: Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.25), radius: 8, x: 0.0, y: 4.0)
                    
                    CustomTextView(text: $text)
                        .padding()
                }
                .padding()
                Spacer()
            }
            .background(Color("grayBg"))
            .navigationBarTitle(Text(fullDate), displayMode: .inline)
            .navigationBarItems(
                trailing: Button("Done") {
                    isShowing = false
//                    todayPage.savePageToDocumentsFolder()
                }
            )
        }
    }
}

struct ChangeView_Previews: PreviewProvider {
    static var previews: some View {
        let todayPage = TodayPage()
        
        ChangeView(text: Binding.constant(todayPage.texts[0]), fullDate: todayPage.pageDate + ", \(todayPage.years[0])", isShowing: Binding.constant(true))
    }
}
