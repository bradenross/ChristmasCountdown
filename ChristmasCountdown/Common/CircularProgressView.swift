//
//  CircularProgressView.swift
//  ChristmasCountdown
//
//  Created by Braden Ross on 6/30/24.
//

import SwiftUI

struct CircularProgressView: View {
    let progress: Double
    var lineWidth: CGFloat = 5
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color.darkGreen.opacity(0.5),
                    lineWidth: lineWidth
                )
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Color.darkGreen,
                    style: StrokeStyle(
                        lineWidth: lineWidth,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut, value: progress)
            if(progress == 1.0) {
                Image(systemName: "checkmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(9)
                    .fontWeight(.bold)
            }

        }
    }
}
