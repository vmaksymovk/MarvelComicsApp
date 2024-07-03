//
//  SeatchBarView.swift
//  MarvelComicsApp
//
//  Created by Влад on 7/3/24.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String
    var onSearchButtonClicked: () -> Void

    var body: some View {
        HStack {
            TextField("Search", text: $text, onCommit: {
                onSearchButtonClicked()
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                onSearchButtonClicked()
            }) {
                Text("Search")
            }
        }
        .padding()
    }
}

