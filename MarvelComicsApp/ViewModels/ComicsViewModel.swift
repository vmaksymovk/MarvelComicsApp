//
//  ComicsViewModel.swift
//  MarvelComicsApp
//
//  Created by Влад on 7/3/24.
//

import Foundation
import Combine

class ComicsViewModel: ObservableObject {
    @Published var comics: [Comic] = []
    @Published var errorMessage: String?

    private var apiClient = MarvelAPIClient()
    private var cancellables = Set<AnyCancellable>()

    func fetchComics() {
        apiClient.fetchComics { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let comics):
                    self?.comics = comics
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
