import SwiftUI

struct ContentView: View {
    @State private var showControls = false
    @State private var isPlaying = false
    @State private var progress: Double = 0
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.black
                    .onTapGesture {
                        withAnimation(self.showControls ? .easeOut : .easeIn) {
                            self.showControls.toggle()
                        }
                    }
                
                Image("tomozaki")
                    .resizable()
                    .scaledToFit()
                    .frame(height: geo.size.height)
                    .zIndex(0)
                
                if self.showControls {
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
                                    Text("12:46")
                                    Text("/")
                                        .foregroundColor(.secondary)
                                    Text("23:47")
                                        .foregroundColor(.secondary)
                                }
                                PercentageSlider(color: .accentColor, percentage: self.$progress)
                            }
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 15)
                        
                        HStack(spacing: 40) {
                            Spacer()
                            SkipBackward()
                            Image(systemName: self.isPlaying ? "pause" : "play")
                                .resizable()
                                .scaledToFit()
                                .frame(width: self.isPlaying ? 30 : 40)
                                .onTapGesture {
                                    self.isPlaying.toggle()
                                }
                            SkipForward()
                            Spacer()
                        }
                    }
                    .zIndex(1)
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
            .onTapGesture {
                withAnimation(self.showControls ? .easeOut : .easeIn) {
                    self.showControls.toggle()
                    
                }
            }
        }
    }
}
