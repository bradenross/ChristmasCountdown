//
//  SettingsPage.swift
//  ChristmasCountdown
//
//  Created by Braden Ross on 6/23/24.
//

import SwiftUI

struct SettingsPage: View {
    @State var musicOnLaunch: Bool = true
    @State var backgroundAudioEnabled: Bool = true
    @State var snowfallEnabled: Bool = true
    
    var body: some View {
        NavigationView {
            VStack(){
                List(){
                    AboutPage()
                    
//                TODO: Add Donation page or payment page if user base grows
//                    Section() {
//                        NavigationLink(destination: DonationsPage()) {
//                            Text("Help the app :)")
//                        }
//                    } header: {
//                        Text("Donate")
//                    }
                    
                    Section() {
                        Toggle("Snowfall", isOn: $snowfallEnabled)
                            .onChange(of: snowfallEnabled) {
                                UserDefaults.standard.setValue(snowfallEnabled, forKey: "snowfallEnabled")
                            }
                    } header: {
                        Text("Countdown")
                    }
                    
                    Section() {
                        Toggle("Music on Launch", isOn: $musicOnLaunch)
                            .onChange(of: musicOnLaunch) {
                                UserDefaults.standard.setValue(musicOnLaunch, forKey: "musicOnLaunch")
                            }
                        
                        Toggle("Enable Background Music", isOn: $backgroundAudioEnabled)
                            .onChange(of: backgroundAudioEnabled) {
                                UserDefaults.standard.setValue(backgroundAudioEnabled, forKey: "backgroundAudioEnabled")
                            }
                        
                    } header: {
                        Text("Music")
                    }
                }
            }
        }
        .safeAreaPadding(.bottom, Constants.Paddings.safeAreaPaddingBottomTabView)
        .onAppear() {
            musicOnLaunch = UserDefaults.standard.bool(forKey: "musicOnLaunch")
            backgroundAudioEnabled = UserDefaults.standard.bool(forKey: "backgroundAudioEnabled")
            snowfallEnabled = UserDefaults.standard.bool(forKey: "snowfallEnabled")
        }
    }
}

#Preview {
    SettingsPage()
}
