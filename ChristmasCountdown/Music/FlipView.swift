//
//  FlipView.swift
//  ChristmasCountdown
//
//  Created by Braden Ross on 6/13/24.
//

import Foundation
import SwiftUI

struct FlipView<Front: View, Back: View>: View {
    @Binding var flipped: Bool
    @Binding var angle: Double

    let front: Front
    let back: Back

    var body: some View {
        ZStack {
            front
                .opacity(flipped ? 0 : 1)
                .rotation3DEffect(
                    .degrees(angle),
                    axis: (x: 0, y: 1, z: 0)
                )
                .zIndex(flipped ? 0 : 1)

            back
                .opacity(flipped ? 1 : 0)
                .rotation3DEffect(
                    .degrees(angle + 180),
                    axis: (x: 0, y: 1, z: 0)
                )
                .zIndex(flipped ? 1 : 0)
        }
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.6)) {
                angle += 180
                flipped.toggle()
            }
        }
        .zIndex(1)
    }
}
