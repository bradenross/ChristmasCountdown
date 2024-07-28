//
//  ContentView.swift
//  ChristmasCountdown
//
//  Created by Braden Ross on 6/11/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedIndex: Int = 0
    
    @StateObject private var songData = SongData()
    @StateObject private var audioPlayer: AudioPlayer
    
    @State var isTabViewHidden: Bool = false

    init() {
        UserDefaults.standard.register(defaults: ["snowfallEnabled": true])
        _audioPlayer = StateObject(wrappedValue: AudioPlayer(tracks: []))
    }
    
    var body: some View {
        CustomTabView(
            isHidden: $isTabViewHidden,
            selectedIndex: $selectedIndex,
            tabBarItems: [
                CustomTabItem(icon: "calendar", view: AnyView(CountdownPage(isUiHidden: $isTabViewHidden)), action: {selectedIndex = 0}),
                CustomTabItem(icon: "music.note", view: AnyView(MusicPage(audioPlayer: audioPlayer, songs: songData.songs)), action: {selectedIndex = 1}),
                CustomTabItem(icon: "list.bullet", view: AnyView(ListsPage()), action: {selectedIndex = 2}),
                CustomTabItem(icon: "book.closed", view: AnyView(VersesPage()), action: {selectedIndex = 3}),
                CustomTabItem(icon: "gearshape", view: AnyView(SettingsPage()), action: {selectedIndex = 4})
            ]
        )
        .onAppear {
            songData.loadSongs()
            songData.songs.shuffle()
            if !songData.songs.isEmpty {
                audioPlayer.tracks = songData.songs
                audioPlayer.loadTrack(at: 0)
                if(UserDefaults.standard.bool(forKey: "musicOnLaunch")) {
                    audioPlayer.play()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
