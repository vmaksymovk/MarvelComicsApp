//
//  ContentView.swift
//  MarvelComicsApp
//
//  Created by Влад on 7/3/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ComicsViewModel()
    @State private var searchText = ""
    @State private var isKeyboardVisible = false
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBarView(text: $searchText, onSearchButtonClicked: {
                    viewModel.searchComicsByTitle(title: searchText)
                })
                List(viewModel.comics) { comic in
                    ComicRowView(comic: comic)
                }
                .navigationTitle("Marvel Comics")
                .onAppear {
                    viewModel.fetchComics()
                }
                .alert(isPresented: .constant(viewModel.errorMessage != nil)) {
                    Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? ""), dismissButton: .default(Text("OK")))
                }
            }
        }
    }
}



#Preview {
    ContentView()
}
