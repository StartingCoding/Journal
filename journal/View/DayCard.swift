//
//  DayCard.swift
//  journal
//
//  Created by Loris on 14/01/21.
//

import SwiftUI

struct DayCard: View {
    @State var text: String
    @State private var isShowing = false
    var fullDate: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20.0)
                .fill(Color("grayBg"))
                .shadow(color: Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.25), radius: 8, x: 0.0, y: 4.0)
            
            Content(textToDisplay: text)
        }
        .padding()
        .onTapGesture {
            isShowing.toggle()
        }
        .sheet(isPresented: $isShowing) {
            ChangeView(showingModal: $isShowing, textToShow: $text, fullDate: fullDate)
        }
    }
}


struct Content: View {
    var textToDisplay: String
    
    var tweetLenght: String {
        var textToLimitChar = ""
        
        for (index, letter) in self.textToDisplay.enumerated() {
            if index <= 140 {
                textToLimitChar.append(letter)
            }
        }
        
        return textToLimitChar
    }
    
    var body: some View {
            Text(tweetLenght)
                .truncationMode(.tail)
                .padding()
    }
}


struct DayCard_Previews: PreviewProvider {
    static var previews: some View {
        let todayPage = TodayPage()
        
        DayCard(text: todayPage.texts[1], fullDate: todayPage.day)
    }
}

