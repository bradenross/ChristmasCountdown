//
//  CountdownTimeSelector.swift
//  ChristmasCountdown
//
//  Created by Braden Ross on 6/12/24.
//

import SwiftUI

struct CountdownTimeSelector: View {
    @Binding var selectedItem: Int
    var selectionItems: [String] = ["Time", "Seconds", "Minutes", "Hours", "Days", "Sleeps", "Breaths", "Heartbeats", "Presents Wrap", "Candy Canes"]
    var body: some View {
        ScrollView(.horizontal){
            HStack(){
                ForEach(Array(selectionItems.enumerated()), id: \.offset){ index, item in
                    Button(action: {selectedItem = index}){
                        Text(item)
                            .fontWeight(.regular)
                            .font(.title3)
                            .foregroundStyle(selectedItem == index ? .white : .black)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 10)
                            .background{
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundStyle(selectedItem == index ? Color("darkGreen") : .white)
                                    .shadow(radius: selectedItem == index ? 0 : 5, y: selectedItem == index ? 0 : 1)
                            }
                    }
                }
            }
            .padding(.vertical, 15)
            .padding(.horizontal, 10)
        }
        .scrollIndicators(.hidden)
    }
}
