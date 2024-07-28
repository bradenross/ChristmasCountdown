//
//  Song.swift
//  ChristmasCountdown
//
//  Created by Braden Ross on 6/14/24.
//

import Foundation

struct Song: Identifiable, Codable {
    let id = UUID()
    let name: String
    let artist: String
    let fileName: String
    let imageName: String
    let time: Double
    let url: String
}
