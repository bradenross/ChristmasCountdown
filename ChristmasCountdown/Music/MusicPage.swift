//
//  MusicPage.swift
//  ChristmasCountdown
//
//  Created by Braden Ross on 6/13/24.
//

import SwiftUI
import AVFoundation

struct MusicPage: View {
    @StateObject private var songData = SongData()
    
    @StateObject private var audioPlayer: AudioPlayer
    @State private var isPlaying = false

    @State private var musicProgress: TimeInterval = 0
    
    @State private var imageFlipped: Bool = false
    @State private var angle: Double = 0
    
    @State private var editingSlider: Bool = false
    
    init(audioPlayer: AudioPlayer, songs: [Song]) {
        _audioPlayer = StateObject(wrappedValue: audioPlayer)
        audioPlayer.tracks = songs
    }
    
    var body: some View {
        VStack(){
            Text("Listening to")
                .truncationMode(.tail)
                .fontWeight(.bold)
                .lineLimit(1)
                .font(.system(size: 25))
                .padding(.bottom, -50)
                .foregroundStyle(.white)
            VStack(){
                FlipView(
                    flipped: $imageFlipped,
                    angle: $angle,
                    front:
                        Image(audioPlayer.tracks[audioPlayer.currentTrackIndex].imageName)
                        .resizable()
                        .frame(width: 300, height: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .shadow(color: .black.opacity(0.7), radius: 10),
                    
                    back:
                        VStack(){
                            Text(audioPlayer.tracks[audioPlayer.currentTrackIndex].name)
                                .multilineTextAlignment(.center)
                                .fontWeight(.bold)
                                .font(.title)
                            Text(audioPlayer.tracks[audioPlayer.currentTrackIndex].artist)
                        }
                        .frame(width: 300, height: 300)
                        .background(Color.white)
                        .foregroundColor(.black)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                )
                .frame(width: 300, height: 300)
                Spacer()
                    .frame(height: 50)
                Text(audioPlayer.tracks[audioPlayer.currentTrackIndex].name)
                    .truncationMode(.tail)
                    .fontWeight(.heavy)
                    .lineLimit(1)
                    .font(.title)
                    .foregroundStyle(.white)
                Text(audioPlayer.tracks[audioPlayer.currentTrackIndex].artist)
                    .font(.subheadline)
                    .foregroundStyle(Color("lightGray"))
            }
            .padding(.vertical, 50)
            .padding(.horizontal, 25)
            Slider(value: $musicProgress, in: 0...1, onEditingChanged: sliderEditingChanged)
                .padding(.horizontal, 25)
                .tint(Color("darkGreen"))
            HStack() {
                Text("\(formattedTime(musicProgress * audioPlayer.totalTime))")
                    .foregroundStyle(.white)
                Spacer()
                Text("\(formattedTime(audioPlayer.totalTime))")
                    .foregroundStyle(.white)
            }
            .padding(.horizontal, 25)
            Spacer()
                .frame(height: 20)
            HStack(spacing: 60){
                Button(action: {
                    imageFlipped = false
                    if((angle / 180).truncatingRemainder(dividingBy: 2) == 1) {
                        angle += 180
                    }
                    resetProgress()
                    audioPlayer.previousTrack()
                }) {
                    Image(systemName: "backward.end.alt.fill")
                        .foregroundStyle(.white)
                        .scaleEffect(2)
                }
                
                Button(action: {
                    if audioPlayer.isPlaying {
                        audioPlayer.pause()
                    } else {
                        audioPlayer.play()
                    }
                }) {
                    ZStack(){
                        Circle()
                            .frame(width: 70, height: 70)
                            .foregroundStyle(.white)
                        Image(systemName: audioPlayer.isPlaying ? "pause.fill" : "play.fill")
                            .foregroundStyle(.red)
                            .scaleEffect(2)
                    }
                }
                
                Button(action: {
                    imageFlipped = false
                    if((angle / 180).truncatingRemainder(dividingBy: 2) == 1) {
                        angle += 180
                    }
                    resetProgress()
                    audioPlayer.nextTrack()
                }) {
                    Image(systemName: "forward.end.alt.fill")
                        .foregroundStyle(.white)
                        .scaleEffect(2)
                }
            }
            Spacer()
                .frame(height: 80)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.red)
        .onAppear {
            if !audioPlayer.tracks.isEmpty {
                audioPlayer.updateTotalTime()
                audioPlayer.startTimer()
                updateMusicProgress() // Immediately update the progress when the view appears
            }
        }
        .onDisappear {
            audioPlayer.stopTimer()
        }
        .onReceive(audioPlayer.$currentTrackIndex) { _ in
            musicProgress = 0
            audioPlayer.updateTotalTime()
            audioPlayer.startTimer()
        }
        .onReceive(audioPlayer.objectWillChange) {
            if !editingSlider, let player = audioPlayer.player {
                self.musicProgress = player.currentTime / audioPlayer.totalTime
            }
        }
    }
    
    private func formattedTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func sliderEditingChanged(editingStarted: Bool) {
        editingSlider = editingStarted
        print(editingSlider)
        if !editingStarted {
            let newTime = audioPlayer.totalTime * musicProgress
            audioPlayer.player?.currentTime = newTime
        }
    }
    
    private func resetProgress() {
        musicProgress = 0
        audioPlayer.player?.currentTime = 0
    }
    
    private func updateMusicProgress() {
        if !editingSlider, let player = audioPlayer.player {
            self.musicProgress = player.currentTime / audioPlayer.totalTime
        }
    }
}
