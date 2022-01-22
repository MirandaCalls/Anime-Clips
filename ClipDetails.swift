import SwiftUI

struct ClipDetails: View {
    let clipTitle: String
    let series: String
    let episodeDetail: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(self.clipTitle)
                .underline()
                .font(.title)
                .padding(.bottom, 5)
            
            VStack(alignment: .leading, spacing: 1) {
                Text(self.series)
                Text(self.episodeDetail)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}
