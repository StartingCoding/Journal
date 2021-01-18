//
//  DayCard.swift
//  journal
//
//  Created by Loris on 14/01/21.
//

import SwiftUI


struct DayCard: View {
    var textToDisplay: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20.0)
                .fill(Color("greyBg"))
                .shadow(color: Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.25), radius: 8, x: 0.0, y: 4.0)
            
            DayText(textToDisplay: textToDisplay)
        }
        .padding()
    }
}


struct DayText: View {
    var textToDisplay: String
    
    var testing: String {
        var result = ""
        
        for (index, letter) in self.textToDisplay.enumerated() {
            if index <= 140 {
                result.append(letter)
            }
        }
        
        return result
    }
    
    var body: some View {
            Text(testing)
                .truncationMode(.tail)
                .padding()
    }
}


struct DayCard_Previews: PreviewProvider {
    static var previews: some View {
        DayCard(textToDisplay: JournalPage().texts[1])
    }
}

