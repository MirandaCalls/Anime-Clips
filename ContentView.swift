import SwiftUI
import AVKit

struct ContentView: View {
    let totalSeconds = 177
    
    @State private var player = AVPlayer(url: Bundle.main.url(forResource: "LifeIsAGodTierGame", withExtension: "mp4")!)
    @State private var showControls = false
    @State private var isPlaying = false
    
    @State private var currentTime: Double = 0
    var formattedCurrentTime: String {
        let total_seconds = Int(self.currentTime)
        let minutes = total_seconds / 60
        let seconds = total_seconds % 60
        return "\(minutes):\(seconds < 10 ? "0\(seconds)" : String(seconds))"
    }
    
    var body: some View {
        ZStack {
            VideoPlayer(player: self.player)
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
                        VideoSlider(player: self.player, color: .accentColor) {
                            self.isPlaying = true
                        }
                    }
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 15)
                
                HStack(spacing: 40) {
                    Spacer()
                    Image(systemName: "gobackward.10")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                        .onTapGesture { self.playerSkipTime(forward: false) }
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
                    Image(systemName: "goforward.10")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                        .onTapGesture { self.playerSkipTime(forward: true) }
                    Spacer()
                }
            }
            .opacity(self.showControls ? 1 : 0)
            .zIndex(1)
        }
        .onTapGesture {
            withAnimation(self.showControls ? .easeOut : .easeIn) {
                self.showControls.toggle()
            }
        }
        .onAppear {
            self.setupAVPlayerListener()
        }
    }
    
    func setupAVPlayerListener() {
        let interval = CMTime(seconds: 1, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        self.player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { time in
            self.currentTime = time.seconds
        }
    }
    
    func playerSkipTime(forward: Bool) {
        let skip_seconds: Double = forward ? 10 : -10
        let current_seconds = self.player.currentTime().seconds
        let interval = CMTime(
            seconds: skip_seconds + current_seconds,
            preferredTimescale: CMTimeScale(NSEC_PER_SEC)
        )
        self.player.seek(to: interval)
    }
}
