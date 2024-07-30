//
//  CountdownPage.swift
//  ChristmasCountdown
//
//  Created by Braden Ross on 6/11/24.
//

import SwiftUI

struct CountdownPage: View {
    @State var selectedItem: Int = 0
    @State var selectedBackground: Int = 0
    @State var backgroundSheetOpen: Bool = false
    @State var isMenuOpen: Bool = false
    @Binding var isUiHidden: Bool

    var body: some View {
        ZStack(alignment: .center) {
            GeometryReader { geometry in
                ZStack() {
                    Image("background\(selectedBackground)")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                        .clipped()
                        .ignoresSafeArea()
                }
                .ignoresSafeArea()
            }
            .ignoresSafeArea()
            if(UserDefaults.standard.bool(forKey: "snowfallEnabled")) {
                SnowfallView()
            }
            VStack(){
                VStack() {
                    Spacer()
                    CountdownTimer(selectedItem: $selectedItem)
                        .padding(.bottom, 100)
                    Spacer()
                }
            }
            VStack() {
                Button(action: {
                    withAnimation {
                        isMenuOpen.toggle()
                    }
                }) {
                    Image(systemName: "plus")
                        .rotationEffect(.degrees(isMenuOpen ? 45 : 0))
                        .fontWeight(.medium)
                        .foregroundStyle(isMenuOpen ? .white : .red)
                        .padding(10)
                        .background() {
                            Circle()
                                .foregroundStyle(isMenuOpen ? .red : .white)
                                .shadow(radius: isMenuOpen ? 0 : 7)
                        }
                        .padding(10)
                }
                if(isMenuOpen) {
                    VStack() {
                        CountdownTypeSelectionMenu(selectedType: $selectedItem)
                        
                        Button(action: {
                            backgroundSheetOpen = true
                        }) {
                            Image(systemName: "photo.on.rectangle")
                                .foregroundStyle(.red)
                                .padding(10)
                                .background() {
                                    Circle()
                                        .foregroundStyle(.white)
                                        .shadow(radius: 7)
                                }
                                .padding(10)
                        }
                        
                        ShareLink(
                            item: URL(string: "https://apps.apple.com/us/christmas-countdown/id6584518026")!,
                            message: Text("Can you believe there is only \(timeUntilChristmas().0.day ?? 0) days left until Christmas?!"),
                            preview: SharePreview("Christmas Countdown")
                        ) {
                            Image(systemName: "square.and.arrow.up")
                                .offset(x: 0, y: -1)
                                .fontWeight(.medium)
                                .foregroundStyle(.red)
                                .padding(10)
                                .background() {
                                    Circle()
                                        .foregroundStyle(.white)
                                        .shadow(radius: 7)
                                }
                                .padding(10)
                        }
                    }
                    .transition(.move(edge: .trailing).combined(with: .opacity))
                    .animation(.spring(), value: isMenuOpen)
                }
            }
            .opacity(isUiHidden ? 0 : 1.0)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        }
        .onLongPressGesture {
            withAnimation(.spring(duration: 0.25)) {
                isUiHidden.toggle()
            }
        }
        .sensoryFeedback(.success, trigger: isUiHidden)
        .onAppear() {
            selectedBackground = UserDefaults.standard.integer(forKey: "countdownBackground")
        }
        .sheet(isPresented: $backgroundSheetOpen) {
            BackgroundImageSelector(selectedBackground: $selectedBackground)
        }
    }
}
