//
//  ComicDetailView.swift
//  MarvelComicsApp
//
//  Created by Влад on 7/3/24.
//

import SwiftUI

struct ComicDetailView: View {
    let comic: Comic
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                AsyncImage(url: URL(string: "\(comic.thumbnail.path).\(comic.thumbnail.extension)")) { image in
                    image
                        .resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(maxWidth: .infinity, maxHeight: 400)
                .scaledToFit()
                .clipped()

                VStack(alignment: .leading, spacing: 10) {
                    Text(comic.title)
                        .font(.title)
                        .fontWeight(.bold)

                    if let description = comic.description {
                        Text(description)
                            .font(.body)
                            
                    } else {
                        Text("No description available")
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                }
                .padding()

                Spacer()
            }
        }
        .navigationTitle("Comic Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
