//
//  SongData.swift
//  ChristmasCountdown
//
//  Created by Braden Ross on 6/14/24.
//

import Foundation
import SwiftUI

class SongData: ObservableObject {
    @Published var songs: [Song] = []
    
    init() {
        loadSongs()
    }
    
    func loadSongs() {
        if let url = Bundle.main.url(forResource: "songList", withExtension: "json"),
           let data = try? Data(contentsOf: url) {
            let decoder = JSONDecoder()
            if let songs = try? decoder.decode([Song].self, from: data) {
                self.songs = songs
            }
        }
    }
}
