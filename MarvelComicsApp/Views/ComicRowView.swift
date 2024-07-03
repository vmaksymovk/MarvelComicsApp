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
            .frame(width: 55, height: 75)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 5)

            VStack(alignment: .leading, spacing: 5) {
                Text(comic.title)
                    .font(.headline)
                    .lineLimit(1)

            }
            .frame(maxWidth: .infinity, alignment: .leading) // Expand to fill available space
            
            Label("", systemImage: "chevron.forward.square")
                .labelsHidden()
                
        }
        
    }
}
