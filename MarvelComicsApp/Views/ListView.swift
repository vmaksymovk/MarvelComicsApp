//
//  ListView.swift
//  MarvelComicsApp
//
//  Created by Влад on 7/3/24.
//

import SwiftUI

struct ListView: View {
    @StateObject private var viewModel = ComicsViewModel()
    @State private var selectedComic: Comic? = nil
    
    var body: some View {
            NavigationStack {
                ZStack {
                    List(viewModel.comics, id: \.self) { comic in
                        ComicRowView(comic: comic)
                            .onTapGesture {
                                selectedComic = comic
                            }
                            .navigationDestination(
                                isPresented: Binding(
                                    get: { selectedComic == comic },
                                    set: { newValue in
                                        if !newValue {
                                            selectedComic = nil
                                        } else {
                                            selectedComic = comic
                                        }
                                    }
                                )
                            ) {
                                ComicDetailView(comic: comic)
                            }
                    }
                    .navigationTitle("Marvel Comics")
                    .searchable(text: $viewModel.searchText)
                    .onAppear {
                        viewModel.fetchComics()
                    }
                    .alert(isPresented: .constant(viewModel.errorMessage != nil)) {
                        Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? ""), dismissButton: .default(Text("OK")))
                    }
                    
                    if viewModel.noResultsFound {
                        VStack {
                            Spacer()
                            ContentUnavailableView.search
                            Spacer()
                        }
                    }
                }
            }
        }
}

#Preview {
    ListView()
}
