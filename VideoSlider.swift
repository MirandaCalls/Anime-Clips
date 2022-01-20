import SwiftUI
import AVKit

struct VideoSlider: View {
    let player: AVPlayer
    let color: Color
    
    @State private var percentage: Double = 0
    @State private var totalLength: CGFloat = 0
    @State private var progressLength: CGFloat = 0
    
    @State private var draggerScale: CGFloat = 1
    @State private var draggerPosition = CGSize.zero
    @State private var draggerOffset = CGSize.zero
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geo.size.width, height: 6)
                    .background(.white.opacity(0.5))
                
                Rectangle()
                    .fill(self.color)
                    .frame(width: self.progressLength, height: 6)
                
                Circle()
                    .frame(width: 20, height: 20)
                    .scaleEffect(self.draggerScale)
                    .shadow(color: .black, radius: 2)
                    .onHover { hovering in
                        withAnimation(.easeIn(duration: 0.1)) {
                            if hovering {
                                self.draggerScale = 1.4
                            } else {
                                self.draggerScale = 1
                            }
                        }
                    }
                    .offset(x: self.draggerPosition.width + self.draggerOffset.width, y: 0)
                    .gesture(
                        DragGesture()
                            .onChanged {
                                self.player.pause()
                                withAnimation(.easeIn(duration: 0.1)) {
                                    self.draggerScale = 1.4
                                }
                                
                                self.draggerOffset.width = self.handleOffsetBounds(
                                    newOffset: $0.translation.width,
                                    totalWidth: geo.size.width
                                )
                                
                                self.progressLength = self.draggerPosition.width + self.draggerOffset.width
                                self.percentage = (self.draggerOffset.width + self.draggerPosition.width) / (geo.size.width - 20)
                            }
                            .onEnded {
                                withAnimation(.easeIn(duration: 0.1)) {
                                    self.draggerScale = 1
                                }
                                
                                self.draggerPosition.width += self.handleOffsetBounds(
                                    newOffset: $0.translation.width,
                                    totalWidth: geo.size.width
                                )
                                self.progressLength = self.draggerPosition.width
                                
                                self.draggerOffset = CGSize.zero
                                
                                let duration = self.player.currentItem?.duration.seconds ?? 0
                                self.seekToTime(for: self.percentage * duration)
                                self.player.play()
                            }
                    )
            }
            .onAppear {
                self.totalLength = geo.size.width
                self.setupAVPlayerListener()
            }
        }
        .frame(height: 20)
    }
    
    func setupAVPlayerListener() {
        let interval = CMTime(seconds: 0.1, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        self.player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { time in
            let duration = self.player.currentItem?.duration.seconds ?? 0
            self.percentage = time.seconds / duration
            withAnimation {
                self.draggerPosition.width = self.percentage * (self.totalLength - 20)
                self.progressLength = self.draggerPosition.width
            }
        }
    }
    
    func seekToTime(for seconds: Double) {
        let interval = CMTime(seconds: seconds, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        self.player.seek(to: interval)
    }
    
    // For ensuring that the dragger never goes off the screen
    func handleOffsetBounds(newOffset: CGFloat, totalWidth: CGFloat) -> CGFloat {
        var final_offset = newOffset
        if self.draggerPosition.width + newOffset < 0 {
            final_offset += abs(newOffset) - self.draggerPosition.width
        }
        
        let final_offset_and_dragger = self.draggerPosition.width + newOffset + 20
        if final_offset_and_dragger > totalWidth {
            final_offset -= final_offset_and_dragger - totalWidth
        }
        
        return final_offset
    }
}
