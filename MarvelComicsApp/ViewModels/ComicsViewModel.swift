import Foundation
import Combine

class ComicsViewModel: ObservableObject {
    @Published var comics: [Comic] = []
    @Published var errorMessage: String?

    private var apiClient = MarvelAPIClient()
    private var cancellables = Set<AnyCancellable>()

    @Published var searchText: String = "" {
        didSet {
            if !searchText.isEmpty {
                searchComicsByTitle(title: searchText)
            } else {
                fetchComics()
            }
        }
    }

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

    func searchComicsByTitle(title: String) {
        apiClient.searchComicsByTitle(title: title) { [weak self] result in
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
