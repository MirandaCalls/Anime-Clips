import SwiftUI
import AVKit

struct PlayButtonStyle: ButtonStyle {
    let isPlaying: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        Image(systemName: self.isPlaying ? "pause.fill" : "play.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 40)
            .scaleEffect(configuration.isPressed ? 0.6 : 1.0)
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
    }
}

struct SkipButtonStyle: ButtonStyle {
    let forward: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        Image(systemName: "go\(self.forward ? "forward" : "backward").10")
            .resizable()
            .scaledToFit()
            .frame(width: 30)
            .scaleEffect(configuration.isPressed ? 0.6 : 1.0)
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
    }
}
