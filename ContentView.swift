import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ClipTile(clip: AnimeClip.example)
                        ClipTile(clip: AnimeClip.example)
                        ClipTile(clip: AnimeClip.example)
                        
                    }
                    .padding(.horizontal, 20)
                }
            }
            .navigationBarTitle("Your Clips")
        }
    }
}
