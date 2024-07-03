//
//  ContentView.swift
//  MarvelComicsApp
//
//  Created by Влад on 7/3/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ComicsViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                List(viewModel.comics) { comic in
                    ComicRowView(comic: comic)
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
                    ContentUnavailableView.search
                }
            }
        }
    }
}



#Preview {
    ContentView()
}
