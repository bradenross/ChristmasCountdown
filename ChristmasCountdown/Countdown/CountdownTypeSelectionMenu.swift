//
//  CountdownTypeSelectionMenu.swift
//  ChristmasCountdown
//
//  Created by Braden Ross on 7/7/24.
//

import SwiftUI

struct CountdownTypeSelectionMenu: View {
    @Binding var selectedType: Int
    
    var selectionItems: [String] = ["Time", "Seconds", "Minutes", "Hours", "Days", "Sleeps", "Breaths", "Heartbeats", "Presents Left to Wrap", "Candy Canes"]
    var body: some View {
        Menu {
            ForEach(Array(selectionItems.enumerated()), id: \.offset){ index, item in
                Button(action: {selectedType = index}){
                    Text(item)
                        .fontWeight(.regular)
                        .font(.title3)
                        .foregroundStyle(selectedType == index ? .white : .black)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .background{
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(selectedType == index ? Color("darkGreen") : .white)
                                .shadow(radius: selectedType == index ? 0 : 5, y: selectedType == index ? 0 : 1)
                        }
                }
            }
        } label: {
            Image(systemName: "calendar.badge.clock")
                .offset(x: 0, y: 1)
                .foregroundStyle(.red)
                .padding(10)
                .background() {
                    Circle()
                        .foregroundStyle(.white)
                        .shadow(radius: 7)
                }
                .padding(10)
        }
    }
}
