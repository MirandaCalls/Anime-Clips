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
    
    init(player: AVPlayer) {
        self.player = player
    }
    
    func makeUIView(context: Context) -> AVPlayerView {
        return AVPlayerView(player: self.player)
    }
    
    func updateUIView(_ uiView: AVPlayerView, context: Context) {}
}
