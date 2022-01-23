import SwiftUI
import AVKit

struct VideoSlider: View {
    let player: AVPlayer
    let color: Color
    let onDragEnd: () -> Void
    
    @State private var percentage: Double = 0
    @State private var progressLength: CGFloat = 0
    
    let draggerSize: CGFloat = 20
    @State private var draggerScale: CGFloat = 1
    @State private var draggerPosition = CGSize.zero
    @State private var draggerOffset = CGSize.zero
    
    var totalDuration: Double {
        self.player.currentItem?.duration.seconds ?? 0
    }
    
    var body: some View {
        GeometryReader { fullPage in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: fullPage.size.width, height: 6)
                    .background(.white.opacity(0.5))
                
                Rectangle()
                    .fill(self.color)
                    .frame(width: self.progressLength, height: 6)
                
                Circle()
                    .frame(width: self.draggerSize, height: self.draggerSize)
                    .scaleEffect(self.draggerScale)
                    .shadow(color: .black, radius: 2)
                    .onHover { hovering in
                        self.updateDraggerKnob(scaleUp: hovering)
                    }
                    .offset(x: self.draggerPosition.width + self.draggerOffset.width, y: 0)
                    .gesture(
                        DragGesture()
                            .onChanged {
                                self.player.pause()
                                self.updateDraggerKnob(scaleUp: true)
                                
                                self.draggerOffset.width = self.handleOffsetBounds(
                                    newOffset: $0.translation.width,
                                    totalWidth: fullPage.size.width
                                )
                                
                                self.progressLength = self.draggerPosition.width + self.draggerOffset.width
                                self.percentage = self.progressLength / self.calculateTotalWidth(fullPage: fullPage)
                            }
                            .onEnded { _ in
                                self.updateDraggerKnob(scaleUp: false)
                                self.draggerOffset = CGSize.zero
                                self.draggerPosition.width = self.percentage * self.calculateTotalWidth(fullPage: fullPage)
                                
                                self.player.seekTo(seconds: self.percentage * self.totalDuration)
                                self.player.play()
                                self.onDragEnd()
                            }
                    )
            }
            .onAppear {
                self.setupAVPlayerListener(fullPage: fullPage)
            }
        }
        .frame(height: self.draggerSize)
    }
    
    func setupAVPlayerListener(fullPage: GeometryProxy) {
        let interval = CMTime(seconds: 0.05, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        self.player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { time in
            let duration = self.totalDuration
            self.percentage = time.seconds / duration
            self.draggerPosition.width = self.percentage * self.calculateTotalWidth(fullPage: fullPage)
            self.progressLength = self.draggerPosition.width
        }
    }
    
    func updateDraggerKnob(scaleUp: Bool) {
        withAnimation(.easeIn(duration: 0.1)) {
            if scaleUp {
                self.draggerScale = 1.4
            } else {
                self.draggerScale = 1
            }
        }
    }
    
    func calculateTotalWidth(fullPage: GeometryProxy) -> CGFloat {
        fullPage.size.width - 20
    }
    
    // For ensuring that the dragger never goes off the screen
    func handleOffsetBounds(newOffset: CGFloat, totalWidth: CGFloat) -> CGFloat {
        var final_offset = newOffset
        if self.draggerPosition.width + newOffset < 0 {
            final_offset += abs(newOffset) - self.draggerPosition.width
        }
        
        let final_offset_and_dragger = self.draggerPosition.width + newOffset + self.draggerSize
        if final_offset_and_dragger > totalWidth {
            final_offset -= final_offset_and_dragger - totalWidth
        }
        
        return final_offset
    }
}
