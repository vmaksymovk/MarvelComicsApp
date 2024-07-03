//
//  Comic.swift
//  MarvelComicsApp
//
//  Created by Влад on 7/3/24.
//

import Foundation

struct Comic: Codable, Identifiable {
    let id: Int
    let title: String
    let description: String?
    let thumbnail: Thumbnail

    struct Thumbnail: Codable {
        let path: String
        let `extension`: String
    }
}
