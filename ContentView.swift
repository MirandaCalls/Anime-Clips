import SwiftUI
import AVKit

struct ContentView: View {
    @State private var player: AVPlayer? = nil
    
    let testClips = [
        AnimeClip.example,
        AnimeClip.example,
        AnimeClip.example
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(self.testClips) { clip in
                                NavigationLink(destination: VideoPlayer(clip: clip)) {
                                    ClipTile(clip: clip)
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                }
                .navigationBarTitle("Your Clips")
                .background(LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom))
                .foregroundColor(.white)
            }
        }
        .onAppear {
            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor  .white]
        }
    }
}
