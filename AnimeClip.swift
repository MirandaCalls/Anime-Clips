import SwiftUI

struct Anime {
    enum Format {
        case series, movie
    }
    
    var title: String
    var type: Anime.Format
}

struct AnimeClip {
    struct FileDetails {
        var fileName: String
        var fileExtension: String
        var imagePreview: String
    }
    
    var id: UUID
    var title: String
    var anime: Anime
    var description: String
    var file: AnimeClip.FileDetails
    
    static public var example: AnimeClip {
        let anime = Anime(title: "Bottom-Tier Character Tomozaki", type: .series)
        let details = FileDetails(fileName: "LifeIsAGodTierGame", fileExtension: ".mp4", imagePreview: "tomozaki")
        
        return AnimeClip(
            id: UUID(),
            title: "Life is a God-Tier Game",
            anime: anime,
            description: "Season 1 Episode 1",
            file: details
        )
    }
}
