import SwiftUI
import AVKit

class AVPlayerView: UIView {
    var player: AVPlayer? {
        get { playerLayer.player }
        set { playerLayer.player = newValue }
    }
    
    init(player: AVPlayer) {
        super.init(frame: .zero)
        self.player = player
        self.backgroundColor = .black

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }
    
    // Override UIView property
    override static var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
}

final class VideoPlayer: UIViewRepresentable {
    let player: AVPlayer
    var onProgressUpdate: (Double) -> Void
    
    init(player: AVPlayer, onProgressUpdate: @escaping (Double) -> Void) {
        self.player = player
        self.onProgressUpdate = onProgressUpdate
    }
    
    func makeUIView(context: Context) -> AVPlayerView {
        let interval = CMTime(seconds: 1, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        self.player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { time in
            self.onProgressUpdate(time.seconds)
        }
        
        return AVPlayerView(player: self.player)
    }
    
    func updateUIView(_ uiView: AVPlayerView, context: Context) {}
}
