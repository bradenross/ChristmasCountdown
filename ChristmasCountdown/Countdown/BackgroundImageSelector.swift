//
//  BackgroundImageSelector.swift
//  ChristmasCountdown
//
//  Created by Braden Ross on 7/2/24.
//

import SwiftUI

struct BackgroundImageSelector: View {
    @Binding var selectedBackground: Int
    var numOfBackgrounds: Int = 14
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack() {
            ScrollView() {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(0..<numOfBackgrounds, id: \.self) { num in
                        Image("background\(num)")
                            .resizable()
                            .frame(maxWidth: 100, maxHeight: 150)
                            .aspectRatio(contentMode: .fill)
                            .padding()
                            .shadow(color: colorScheme == .dark ? .white : .black, radius: selectedBackground == num ? 10 : 0)
                            .onTapGesture {
                                selectedBackground = num
                                print("HERE")
                            }
                    }
                }
            }
            .navigationTitle("Background")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark")
                    }
                }
            }
            .onDisappear() {
                UserDefaults.standard.setValue(selectedBackground, forKey: "countdownBackground")
            }
        }
    }
}
