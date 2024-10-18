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
                Text("Visit our [Instagram](https://www.instagram.com/xmascountdownapp/)!")
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 25)
                Text("Christmas list icons created by [Umeicon](https://www.flaticon.com/authors/umeicon)")
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
