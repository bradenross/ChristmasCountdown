//
//  ChristmasCountdownApp.swift
//  ChristmasCountdown
//
//  Created by Braden Ross on 6/11/24.
//

import AVFoundation
import SwiftUI

@main
struct ChristmasCountdownApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        // Check user preference for background audio
//        let backgroundAudioEnabled = UserDefaults.standard.bool(forKey: "backgroundAudioEnabled")
//        
//        if backgroundAudioEnabled {
//            // Configure and activate the audio session
//            do {
//                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: backgroundAudioEnabled ? [] : [.mixWithOthers])
//                try AVAudioSession.sharedInstance().setActive(true)
//            } catch {
//                print("Failed to set up audio session: \(error)")
//            }
//        }

        return true
    }
}
