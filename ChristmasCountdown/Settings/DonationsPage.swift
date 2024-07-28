//
//  DonationsPage.swift
//  ChristmasCountdown
//
//  Created by Braden Ross on 7/27/24.
//

import SwiftUI

struct DonationsPage: View {
    var body: some View {
        VStack() {
            Link(destination: URL(string: "https://account.venmo.com/u/BradenRoss")!, label: {
                VStack() {
                    Image("Venmo_logo")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .aspectRatio(contentMode: .fit)
                }
            })
            .padding()
            Text("Help me improve and keep the app running :)")
                .multilineTextAlignment(.center)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom, 10)
            Text("With the funding, I would like to implement features such as an online database, better/more music, app size improvement, and more! 100% of donations will be put back into the app. It will also help keep the app ad free!")
                .multilineTextAlignment(.center)
        }
        .padding()
        .safeAreaPadding(.bottom, Constants.Paddings.safeAreaPaddingBottomTabView)
    }
}

#Preview {
    DonationsPage()
}
