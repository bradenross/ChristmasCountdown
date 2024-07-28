//
//  CustomTabBar.swift
//  ChristmasCountdown
//
//  Created by Braden Ross on 6/17/24.
//

import SwiftUI

struct CustomTabView: View {
    @Binding var isHidden: Bool
    @Binding var selectedIndex: Int
    let tabBarItems: [CustomTabItem]
    
    var body: some View {
        ZStack() {
            if tabBarItems.indices.contains(selectedIndex) {
                tabBarItems[selectedIndex].view
            } else {
                Text("Error! :( Please email bradenhross@gmail.com so we can fix this!")
            }
            
            VStack() {
                Spacer()
                HStack {
                    ForEach(0..<tabBarItems.count, id: \.self) { index in
                        if(index == selectedIndex) {
                            ZStack(){
                                Circle()
                                    .fill(.red)
                                    .frame(width: Constants.Dimensions.tabBarItemWidth, height: Constants.Dimensions.tabBarItemHeight)
                                tabBarItems[selectedIndex]
                                    .foregroundStyle(.white)
                            }
                            .frame(width: Constants.Dimensions.tabBarItemWidth, height: Constants.Dimensions.tabBarItemHeight)
                            .layoutPriority(1)
                        } else {
                            tabBarItems[index]
                                .foregroundStyle(.black)
                                .frame(width: Constants.Dimensions.tabBarItemWidth, height: Constants.Dimensions.tabBarItemHeight)
                                .layoutPriority(1)
                        }
                        
                        if index < tabBarItems.count - 1 {
                            Spacer()
                        }
                    }
                }
                .frame(maxHeight: Constants.Dimensions.tabViewHeight)
                .padding(.horizontal, 3)
                .background {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.white)
                        .shadow(radius: 7)
                }
                .padding(.horizontal, 15)
            }
            .opacity(isHidden ? 0 : 1.0)
        }
    }
}

struct CustomTabItem: View {
    var icon: String = "house"
    let view: AnyView
    let action: () -> Void
    
    var body: some View {
        Button(action: action){
            Image(systemName: icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 28, height: 28)
        }
    }
}
