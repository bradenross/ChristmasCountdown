//
//  VersesPage.swift
//  ChristmasCountdown
//
//  Created by Braden Ross on 6/13/24.
//

import SwiftUI

struct VersesPage: View {
    @StateObject var verses: VerseData = VerseData()

    var body: some View {
        VStack(){
            if let verseIndex = getCurrentDayIndex(), verseIndex < verses.verses.count {
                Text("\(verses.verses[verseIndex].verse)")
                    .verseTextStyle()
                Text("\(verses.verses[verseIndex].chapter)")
                    .verseTextStyle()
            } else {
                Text("Loading...")
                    .verseTextStyle()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background{
            Image("bible-verses-background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()
                .ignoresSafeArea()
        }
    }
    
    private func getCurrentDayIndex() -> Int? {
        let day = Calendar.current.component(.day, from: Date())
        return day > 0 ? day - 1 : nil
    }
}

#Preview {
    VersesPage()
}


struct VerseTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .multilineTextAlignment(.center)
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .shadow(color: Color.black, radius: 2, x: 0, y: 0)
            .padding()
            .cornerRadius(10)
    }
}

extension View {
    func verseTextStyle() -> some View {
        self.modifier(VerseTextStyle())
    }
}
