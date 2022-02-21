import SwiftUI

struct ClipTile: View {
    let clip: AnimeClip
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                Image(self.clip.file.imagePreview)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 180, height: 100)
                    .clipShape(Rectangle())
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.secondary, lineWidth: 1)
                    )
                    .shadow(radius: 5)
                Image(systemName: "play.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40)
                    .opacity(0.8)
            }
            .foregroundColor(.white)
            Text(self.clip.title)
                .font(.caption)
        }
    }
}
