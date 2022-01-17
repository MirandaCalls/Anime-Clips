import SwiftUI
import AVKit

struct ContentView: View {
    let totalSeconds = 177
    
    @State private var showControls = false
    @State private var isPlaying = false
    @State private var progress: Double = 0
    @State private var currentTime: Double = 0
    @State private var player = AVPlayer(url: Bundle.main.url(forResource: "LifeIsAGodTierGame", withExtension: "mp4")!)
    
    var formattedCurrentTime: String {
        let total_seconds = Int(self.currentTime)
        let minutes = total_seconds / 60
        let seconds = total_seconds % 60
        return "\(minutes):\(seconds < 10 ? "0\(seconds)" : String(seconds))"
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VideoPlayer(player: self.player) { seconds in
                    // Update the UI as the video plays
                    self.currentTime = seconds
                    self.progress = seconds / Double(self.totalSeconds)
                }
                
                if self.showControls {
                    ZStack {
                        Color.black.opacity(0.5)
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Bottom-Tier Character Tomozaki")
                                    .underline()
                                    .font(.title)
                                    .padding(.bottom, 5)
                                Spacer()
                                Image(systemName: "xmark.circle.fill")
                            }
                            VStack(alignment: .leading, spacing: 1) {
                                Text("Season 1 Episode 11")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text("A single choice can change everything")
                                Text("English - Simulcast")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("\(self.formattedCurrentTime)")
                                    Text("/")
                                        .foregroundColor(.secondary)
                                    Text("2:57")
                                        .foregroundColor(.secondary)
                                }
                                PercentageSlider(color: .accentColor, percentage: self.$progress)
                            }
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 15)
                        
                        HStack(spacing: 40) {
                            Spacer()
                            SkipBackward()
                            Image(systemName: self.isPlaying ? "pause" : "play")
                                .resizable()
                                .scaledToFit()
                                .frame(width: self.isPlaying ? 30 : 40)
                                .onTapGesture {
                                    self.isPlaying.toggle()
                                    if self.isPlaying {
                                        self.player.play()
                                    } else {
                                        self.player.pause()
                                    }
                                }
                            SkipForward()
                            Spacer()
                        }
                    }
                    .zIndex(1)
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
            .onTapGesture {
                withAnimation(self.showControls ? .easeOut : .easeIn) {
                    self.showControls.toggle()
                }
            }
        }
    }
}
