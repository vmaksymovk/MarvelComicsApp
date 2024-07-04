
import Foundation

struct Comic: Codable, Identifiable, Equatable, Hashable {
    let id: Int
    let title: String
    let description: String?
    let thumbnail: Thumbnail
    let name: String?
    
    struct Thumbnail: Codable {
        let path: String
        let `extension`: String
    }
    
    static func == (lhs: Comic, rhs: Comic) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}




