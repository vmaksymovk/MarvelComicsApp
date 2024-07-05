import SwiftUI

struct ComicRowView: View {
    let comic: Comic
    
    var body: some View {
        HStack(spacing: 10) {
            AsyncImage(url: URL(string: "\(comic.thumbnail.path).\(comic.thumbnail.extension)")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
            .frame(width: 116, height: 183)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 5)

            VStack(alignment: .leading, spacing: 5) {
                Text(comic.title)
                    .font(.headline)
                    .lineLimit(.max)

                if let writer = comic.creators.items.first(where: { $0.role.lowercased() == "writer" }) {
                    Text("written by \(writer.name)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                } else {
                    Text("written by unknown")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                if let description = comic.description {
                    Text(description)
                        .font(.body)
                        .lineLimit(3) 
                } else {
                    Text("No description available")
                        .font(.body)
                        .foregroundColor(.secondary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
