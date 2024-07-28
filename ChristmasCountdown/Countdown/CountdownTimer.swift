//
//  CountdownTimer.swift
//  ChristmasCountdown
//
//  Created by Braden Ross on 6/12/24.
//

import SwiftUI

struct CountdownTimer: View {
    @Binding var selectedItem: Int
    @State private var timeRemaining = timeUntilChristmas().0
    @State private var totalSeconds = timeUntilChristmas().totalSeconds
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var selectionItems: [String] = ["Time", "Seconds", "Minutes", "Hours", "Days", "Sleeps", "Breaths", "Heartbeats", "Presents Left", "Candy Canes"]
    
    var body: some View {
        VStack(spacing: 0){
            switch selectedItem {
            case 0:
                Text("\(totalTimeString())\nUntil Christmas!")
                    .countdownTextStyle()
            case 1:
                Text("\(totalSeconds) Seconds\nUntil Christmas!")
                    .countdownTextStyle()
            case 2:
                Text("\(totalSeconds / 60) Minutes\nUntil Christmas!")
                    .countdownTextStyle()
            case 3:
                Text("\(totalSeconds / 3600) Hours\nUntil Christmas!")
                    .countdownTextStyle()
            case 4:
                Text("\((timeRemaining.day ?? 0)) Days\nUntil Christmas!")
                    .countdownTextStyle()
            case 5:
                Text("\((timeRemaining.day ?? 0) + 1) Sleeps\nUntil Christmas!")
                    .countdownTextStyle()
            case 6:
                Text("\(totalSeconds / (3600 / 1500)) Breaths\nUntil Christmas!")
                    .countdownTextStyle()
            case 7:
                Text("\(totalSeconds * (4800 / 3600)) Heartbeats\nUntil Christmas!")
                    .countdownTextStyle()
            case 8:
                VStack(spacing: 0){
                    Text("\(totalSeconds * 10 * 7000000000 / 600)")
                        .countdownTextStyle()
                        .minimumScaleFactor(0.01)
                        .lineLimit(1)
                    Text("Presents Left to Wrap\nUntil Christmas!")
                        .countdownTextStyle()
                }
            case 9:
                Text("\(totalSeconds / 1080) Candy Canes to Eat\nUntil Christmas!")
                    .countdownTextStyle()
            default:
                Text("Christmas is coming!!!")
            }
        }
        .onReceive(timer) { _ in
            let result = timeUntilChristmas()
            self.timeRemaining = result.0
            self.totalSeconds = result.totalSeconds
        }
    }
    
    private func totalTimeString() -> String {
        let days = timeRemaining.day ?? 0
        let hours = timeRemaining.hour ?? 0
        let minutes = timeRemaining.minute ?? 0
        let seconds = timeRemaining.second ?? 0
        return "\(days) Days\n\(hours) Hours\n\(minutes) Minutes\n\(seconds) Seconds"
    }
}

import SwiftUI

func timeUntilChristmas() -> (DateComponents, totalSeconds: Int) {
    let calendar = Calendar.current
    let now = Date()
    
    var christmasDateComponents = DateComponents()
    christmasDateComponents.year = calendar.component(.year, from: now)
    christmasDateComponents.month = 12
    christmasDateComponents.day = 25
    christmasDateComponents.hour = 0
    christmasDateComponents.minute = 0
    christmasDateComponents.second = 0
    
    let christmas = calendar.date(from: christmasDateComponents)!
    
    let components = calendar.dateComponents([.day, .hour, .minute, .second], from: now, to: christmas)
    
    let totalSeconds = calendar.dateComponents([.second], from: now, to: christmas).second ?? 0
    
    return (components, totalSeconds)
}

struct CountdownTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .multilineTextAlignment(.center)
            .font(.system(size: 40))
            .fontWeight(.bold)
            .foregroundColor(.white)
            .shadow(color: Color.black, radius: 2, x: 0, y: 0)
            .padding()
            .cornerRadius(10)
    }
}

extension View {
    func countdownTextStyle() -> some View {
        self.modifier(CountdownTextStyle())
    }
}
