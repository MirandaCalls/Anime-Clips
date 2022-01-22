import SwiftUI
import AVKit

struct SkipButton: View {
    let player: AVPlayer
    let forward: Bool
    
    var body: some View {
        Image(systemName: "go\(self.forward ? "forward" : "backward").10")
            .resizable()
            .scaledToFit()
            .frame(width: 30)
            .onTapGesture { 
                self.player.skip(seconds: self.forward ? 10 : -10)
            }
    }
}
