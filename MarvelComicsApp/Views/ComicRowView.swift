//
//  ComicRowView.swift
//  MarvelComicsApp
//
//  Created by Влад on 7/3/24.
//

import SwiftUI

struct ComicRowView: View {
    let comic: Comic

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: "\(comic.thumbnail.path).\(comic.thumbnail.extension)")) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 75)
            .clipShape(RoundedRectangle(cornerRadius: 5))

            VStack(alignment: .leading, spacing: 5) {
                Text(comic.title)
                    .font(.headline)
                if let description = comic.description {
                    Text(description)
                        .font(.subheadline)
                        .lineLimit(2)
                }
            }
        }
    }
}


//#Preview {
//    ComicRowView(comic: <#Comic#>)
//}
