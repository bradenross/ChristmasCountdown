//
//  SnowfallView.swift
//  ChristmasCountdown
//
//  Created by Braden Ross on 7/24/24.
//

import SwiftUI

struct SnowfallView: View {
    var body: some View {
        ZStack {
            ForEach(0..<100, id: \.self) { index in
                Snowflake(delay: Double(index) * 0.1)
            }
        }
    }
}

struct Snowflake: View {
    @State private var offsetY: CGFloat = -100
    @State private var xPos: CGFloat = CGFloat.random(in: 0...UIScreen.main.bounds.width)
    @State private var size: CGFloat = CGFloat.random(in: 2...8)
    @State private var duration: Double = Double.random(in: 3...7)
    
    var delay: Double
    
    var body: some View {
        Circle()
            .fill(Color.white)
            .frame(width: size, height: size)
            .position(x: xPos, y: offsetY)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    withAnimation(Animation.linear(duration: duration).repeatForever(autoreverses: false)) {
                        offsetY = UIScreen.main.bounds.height + 50
                    }
                }
            }
    }
}
