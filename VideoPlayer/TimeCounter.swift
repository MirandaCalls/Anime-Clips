import SwiftUI
import AVKit

struct TimeCounter: View {
    let player: AVPlayer
    var totalSeconds: Int
    var formattedTotalSeconds: String {
        self.format(seconds: Int(self.totalSeconds))
    }
    
    @State private var currentSeconds: Double = 0
    var formattedCurrentTime: String {
        self.format(seconds: Int(self.currentSeconds))
    }
    
    var body: some View {
        HStack {
            Text("\(self.formattedCurrentTime)")
            Text("/")
                .foregroundColor(.secondary)
            Text("\(self.formattedTotalSeconds)")
                .foregroundColor(.secondary)
        }
        .onAppear {
            self.setupSecondsCounter()
        }
    }
    
    func setupSecondsCounter() {
        let interval = CMTime(seconds: 1, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        self.player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { time in
            self.currentSeconds = time.seconds
        }
    }
    
    func format(seconds total: Int) -> String {
        let minutes = total / 60
        let seconds = total % 60
        return "\(minutes):\(seconds < 10 ? "0\(seconds)" : String(seconds))"
    }
}
