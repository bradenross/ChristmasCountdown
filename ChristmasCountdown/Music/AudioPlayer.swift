//
//  AudioPlayer.swift
//  ChristmasCountdown
//
//  Created by Braden Ross on 6/13/24.
//

import Foundation
import SwiftUI
import AVFoundation
import Combine

class AudioPlayer: NSObject, ObservableObject, AVAudioPlayerDelegate {
    var player: AVAudioPlayer?
    var timeObserverToken: Any?
    var cancellable: AnyCancellable?

    @Published var isPlaying: Bool = false
    @Published var isPlayingPreviousState: Bool = false
    @Published var currentTrackIndex: Int = 0
    @Published var totalTime: TimeInterval = 0
    @Published private var backgroundAudioEnabled: Bool = UserDefaults.standard.bool(forKey: "backgroundAudioEnabled")
    var tracks: [Song] = []
    
    var timer: Timer?
    
    init(tracks: [Song]) {
        self.tracks = tracks
        super.init()
        setupAudioSession()
        loadTrack(at: currentTrackIndex)
        observeUserDefaultsChanges()
    }

    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: backgroundAudioEnabled ? [] : [.mixWithOthers])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set up audio session.")
        }
    }
    
    private func observeUserDefaultsChanges() {
        cancellable = NotificationCenter.default.publisher(for: UserDefaults.didChangeNotification)
            .sink { [weak self] _ in
                self?.backgroundAudioEnabled = UserDefaults.standard.bool(forKey: "backgroundAudioEnabled")
                self?.setupAudioSession()
            }
    }

    func loadTrack(at index: Int) {
        guard index < tracks.count else { return }
        let track = tracks[index]
        if let path = Bundle.main.path(forResource: track.fileName, ofType: "mp3") {
            let url = URL(fileURLWithPath: path)
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player?.delegate = self
                player?.prepareToPlay()
            } catch {
                print("Error: Could not find and play the sound file.")
            }
        }
    }

    func play() {
        player?.play()
        isPlaying = true
        player?.volume = 0.5
    }

    func pause() {
        player?.pause()
        isPlaying = false
    }

    func stop() {
        player?.pause()
        isPlaying = false
    }
    
    func nextTrack() {
        stop()
        currentTrackIndex = (currentTrackIndex + 1) % tracks.count
        loadTrack(at: currentTrackIndex)
        updateTotalTime()
        play()
    }

    func previousTrack() {
        stop()
        currentTrackIndex = (currentTrackIndex - 1 + tracks.count) % tracks.count
        loadTrack(at: currentTrackIndex)
        play()
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        nextTrack()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.objectWillChange.send()
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func updateTotalTime() {
        totalTime = player?.duration ?? 0
    }
    
    func handleAppInBackground() {
        if !backgroundAudioEnabled {
            isPlayingPreviousState = isPlaying
            pause()
        }
    }
    
    func handleAppInForeground() {
        if !backgroundAudioEnabled && isPlayingPreviousState {
            play()
        }
    }
}
