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

            }
            .frame(maxWidth: .infinity, alignment: .leading) 
            
            
                
        }
        
    }
}
