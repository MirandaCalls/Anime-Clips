import SwiftUI
import AVKit

/**
 * TODO
 * - Make skip buttons jump a little when tapped
 * - Make the video reset to the beginning when it finishes
 */

struct ContentView: View {
    let totalSeconds = 177
    
    @State private var player = AVPlayer(url: Bundle.main.url(forResource: "LifeIsAGodTierGame", withExtension: "mp4")!)
    @State private var showOverlay = false
    @State private var isPlaying = false
    
    var body: some View {
        ZStack {
            VideoPlayer(player: self.player)
            ZStack {
                Color.black.opacity(0.5)
                VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        ClipDetails(
                            clipTitle: "Life is a God-Tier Game!",
                            series: "Bottom-Tier Character Tomozaki",
                            episodeDetail: "Season 1 Episode 1"
                        )
                        Spacer()
                        Image(systemName: "xmark.circle.fill")
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        TimeCounter(player: self.player, totalSeconds: self.totalSeconds)
                        VideoSlider(player: self.player, color: .accentColor) {
                            // When the user has finished dragging, resume playing
                            self.isPlaying = true
                        }
                    }
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 15)
                
                HStack(spacing: 40) {
                    Spacer()
                    SkipButton(player: self.player, forward: false)
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
                    SkipButton(player: self.player, forward: true)
                    Spacer()
                }
            }
            .opacity(self.showOverlay ? 1 : 0)
            .zIndex(1)
        }
        .onTapGesture {
            withAnimation(self.showOverlay ? .easeOut : .easeIn) {
                self.showOverlay.toggle()
            }
        }
    }
}
