//
//  ContentView.swift
//  MarvelComicsApp
//
//  Created by Влад on 7/3/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isSelectedView : Int = 1
    var body: some View {
        TabView(selection: $isSelectedView){
            ListView()
                .tabItem {
                    Label("List", systemImage: "list.bullet.rectangle.portrait")
                }
        }
    }
}

#Preview {
    ContentView()
}
