import SwiftUI

struct MediaSkipShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxY, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        
        
        return path
    }
}

struct SkipBackward: View {
    var body: some View {
        MediaSkipShape()
            .stroke(.white, style: StrokeStyle(lineWidth: 3.5, lineCap: .round, lineJoin: .round))
            .frame(width: 30, height: 30)
    }
}

struct SkipForward: View {
    var body: some View {
        SkipBackward()
            .rotationEffect(.degrees(180))
    }
}
