//
//  ListPersonItem.swift
//  ChristmasCountdown
//
//  Created by Braden Ross on 6/23/24.
//

import SwiftUI

struct ListPersonItem: View {
    var listInfo: ChristmasList
    var body: some View {
        HStack() {
            Image(listInfo.image)
                .resizable()
                .frame(width: 40, height: 40)
                .aspectRatio(contentMode: .fit)
                .padding(8)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color("darkGreen"))
                }
            VStack() {
                Text(listInfo.name)
                    .fontWeight(.bold)
            }
            Spacer()
            VStack() {
                CircularProgressView(progress: Double(listInfo.numberOfItemsBought())/Double(listInfo.items.count))
                    .frame(width: 30, height: 30)
                Text("\(listInfo.numberOfItemsBought())/\(listInfo.items.count)")
            }
            .frame(width: 60)
        }
    }
}
