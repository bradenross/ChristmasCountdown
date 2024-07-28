//
//  Verse.swift
//  ChristmasCountdown
//
//  Created by Braden Ross on 7/7/24.
//

import Foundation

struct Verse: Identifiable, Codable {
    let id = UUID()
    let chapter: String
    let verse: String
}
