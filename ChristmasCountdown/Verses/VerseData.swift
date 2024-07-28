//
//  VerseData.swift
//  ChristmasCountdown
//
//  Created by Braden Ross on 7/7/24.
//

import Foundation
import SwiftUI

class VerseData: ObservableObject {
    @Published var verses: [Verse] = []
    
    init() {
        loadVerses()
    }
    
    func loadVerses() {
        if let url = Bundle.main.url(forResource: "verses", withExtension: "json"),
           let data = try? Data(contentsOf: url) {
            let decoder = JSONDecoder()
            if let verses = try? decoder.decode([Verse].self, from: data) {
                self.verses = verses
            }
        }
    }
}

