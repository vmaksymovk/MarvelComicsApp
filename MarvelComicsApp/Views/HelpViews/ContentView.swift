//
//  ContentView.swift
//  MarvelComicsApp
//
//  Created by Влад on 7/3/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isSelectedView: Int = 1
    
    var body: some View {
        TabView(selection: $isSelectedView) {
            ListView()
                .tabItem {
                    Image(systemName: "house")
                }
                .tag(1)
            
            SearchBarView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                        
                }
                .tag(2)
        }
        .accentColor(.red)
    }
}



#Preview {
    ContentView()
}
