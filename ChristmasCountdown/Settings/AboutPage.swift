//
//  AboutPage.swift
//  ChristmasCountdown
//
//  Created by Braden Ross on 6/23/24.
//

import SwiftUI

struct AboutPage: View {
    var body: some View {
        Section(){
            VStack(alignment: .center) {
                Text("App designed, developed, and published by Braden Ross")
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 25)
                Text("Christmas list icons created by [Umeicon](https://www.flaticon.com/authors/umeicon)\n[Christmas icons created by Umeicon - Flaticon](https://www.flaticon.com/free-icons/christmas)")
                    .multilineTextAlignment(.center)
                    .font(.callout)
            }
        } header: {
            Text("About")
        }
    }
}

#Preview {
    AboutPage()
}
