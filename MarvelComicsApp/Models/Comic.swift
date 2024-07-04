
import Foundation

struct Comic: Codable, Identifiable, Equatable, Hashable {
    let id: Int
    let title: String
    let description: String?
    let thumbnail: Thumbnail
    let urls: [ComicURL]
    
    struct Thumbnail: Codable {
        let path: String
        let `extension`: String
    }
    
    struct ComicURL: Codable {
            let type: String
            let url: String
        }
    
    static func == (lhs: Comic, rhs: Comic) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}




