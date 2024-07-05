import SwiftUI

struct ComicDetailView: View {
    let comic: Comic

    var body: some View {
        VStack {
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
                            ScrollView { 
                                Text(description)
                                    .font(.body)
                            }
                            .frame(maxHeight: 200)
                        } else {
                            Text("No description available")
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Comic Details")
            .navigationBarTitleDisplayMode(.inline)

            if let url = comic.urls.first(where: { $0.type == "detail" })?.url {
                Button(action: {
                    if let link = URL(string: url) {
                        UIApplication.shared.open(link)
                    }
                }) {
                    Text("Find out more")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(10)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white)
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}
