import SwiftUI
import AVKit

struct VideoPlayer: View {
    @Environment(\.presentationMode) var presentationMode
    let clip: AnimeClip
    let player: AVPlayer
    
    @State private var showOverlay = false
    @State private var isPlaying = true
    
    init(clip: AnimeClip) {
        self.clip = clip
        let url = Bundle.main.url(forResource: clip.file.fileName, withExtension: clip.file.fileExtension)!
        self.player = AVPlayer(url: url)
    }
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            VideoLayer(player: self.player)
            ZStack {
                Color.black.opacity(0.5)
                VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        ClipDetails(
                            clipTitle: self.clip.title,
                            series: self.clip.anime.title,
                            episodeDetail: self.clip.description
                        )
                        Spacer()
                        Image(systemName: "xmark.circle.fill")
                            .onTapGesture {
                                self.player.pause()
                                self.presentationMode.wrappedValue.dismiss()
                            }
                            .padding(.top, 10)
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        TimeCounter(player: self.player, totalSeconds: self.clip.length)
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
                    Button("Skip Backward") {
                        self.player.skip(seconds: -10)
                    }.buttonStyle(SkipButtonStyle(forward: false))
                    Button("Play/Pause") {
                        self.isPlaying.toggle()
                        if self.isPlaying {
                            self.player.play()
                        } else {
                            self.player.pause()
                        }
                    }.buttonStyle(PlayButtonStyle(isPlaying: self.isPlaying))
                    Button("Skip Forward") {
                        self.player.skip(seconds: 10)
                    }.buttonStyle(SkipButtonStyle(forward: true))
                    Spacer()
                }
            }
            .opacity(self.showOverlay ? 1 : 0)
            .zIndex(1)
        }
        .foregroundColor(.white)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onTapGesture {
            withAnimation(self.showOverlay ? .easeOut : .easeIn) {
                self.showOverlay.toggle()
            }
        }
        .onAppear {
            self.player.play()
        }
    }
}
